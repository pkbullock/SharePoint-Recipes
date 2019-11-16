<# 

Created:      Paul Bullock
Date:         16/11/2019
License:      MIT License (MIT)
Disclaimer:   

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


.Synopsis

    Example Script for demo used in SharePoint Saturday Leicester 2019
    Converts all news publishing pages from an on-premises server


.Example

     Generate mapping and store in "MappingFiles" folder
    
        $sourceConn = Connect-PnPOnline http://2013/en -ReturnConnection

    To generate mapping files, see Export-PnPClientSidePageMapping cmdlet
    Get mapping for Single Page:

        Export-PnPClientSidePageMapping -CustomPageLayoutMapping -Connection $sourceConn -Folder "$(Get-Location)\MappingFiles"
    
    Get mapping for all page layouts
        
        Export-PnPClientSidePageMapping -PublishingPage "Article-Custom-Page-Layout.aspx" -CustomPageLayoutMapping -Connection $sourceConn -Folder "$(Get-Location)\MappingFiles"

.Notes
    
    Useful references:
        - https://github.com/SharePoint/sp-dev-modernization
        - https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/convertto-pnpclientsidepage?view=sharepoint-ps
        - https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/?view=sharepoint-ps
        
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false, HelpMessage = "Source e.g. Intranet-Archive")]
    [string]$SourceUrl = "http://2013/en",

    [Parameter(Mandatory = $false, HelpMessage = "Target e.g. Intranet")]
    [string]$TargetSitePartUrl = "PnPKatchup-News",

    [Parameter(Mandatory = $false, HelpMessage = "Organisation Url Fragment e.g. contoso ")]
    [string]$PartTenant = "contoso",
 
    [Parameter(Mandatory = $false, HelpMessage = "Specify Page Layout File")]
    [string]$PageLayoutMappingFile = "custompagelayoutmapping-2013-news.xml"
)
begin{

    $baseUrl = "https://$($PartTenant).sharepoint.com"
    $sourceSiteUrl = $SourceUrl
    $targetSiteUrl = "$($baseUrl)/sites/$($TargetSitePartUrl)"
    $LogOutputFolder = "c:\temp"
    $UserFileMapping = "$(Get-Location)\MappingFiles\usermapping.csv"
    
    # To transform to On-Premises servers you need to create connections to both source and target
    # Note: that not all PnP commands work against SharePoint 2010, this script is designed for transform only
    $sourceConnection = Connect-PnPOnline -Url $sourceSiteUrl -ReturnConnection
    Write-Host "Connected to " $sourceSiteUrl

    # This connection should target SharePoint Online
    $targetConnection = Connect-PnPOnline -Url $targetSiteUrl -ReturnConnection
    Write-Host "Connected to " $targetSiteUrl

}
process {

    Write-Host "Converting site..." -ForegroundColor Cyan

    $pages = Get-PnPListItem -List "Pages" -Connection $sourceConnection
        
    Foreach($page in $pages){

        if($page.FieldValues["FileDirRef"] -eq "/en/Pages/News"){

            $targetFileName = $page.FieldValues["FileLeafRef"]

            # Skip pages 
            # typical for flattening multiple sites that contain standard page(s) e.g. Welcome.aspx or Default.aspx
            if($targetFileName -eq "About-Us.aspx" -or $targetFileName -eq "Home.aspx"  -or $targetFileName -eq "default.aspx"){

                #$targetFileName  = "Welcome-2010.aspx"
                #Write-Host " - Updating Welcome.aspx page to $($targetFileName)" -ForegroundColor Yellow
                Write-Host "  Skipping page $($targetFileName)" -ForegroundColor Yellow
                continue
            }

            Write-Host " Processing $($targetFileName)" -ForegroundColor Cyan

            Write-Host " Modernizing $($targetFileName)..." -ForegroundColor Cyan

            # Use -Connection parameter to pass the source 201X SharePoint connection
            # Use -TargetConnection to pass in the target connection to SharePoint Online modern site,
            #   no need to use -TargetUrl in this case
            $result = ConvertTo-PnPClientSidePage -Identity $page.FieldValues["FileLeafRef"] `
                        -PublishingPage `
                        -TargetConnection $targetConnection `
                        -PublishingTargetPageName $targetFileName `
                        -PageLayoutMapping "$(Get-Location)\MappingFiles\$($PageLayoutMappingFile)" `
                        -Connection $sourceConnection `
                        -PostAsNews `
                        -Overwrite `
                        -LogType Console `
                        -UserMappingFile $UserFileMapping `
                        -KeepPageCreationModificationInformation `
                        -LogSkipFlush `
                        -LogFolder $LogOutputFolder
        
            if($result){

                Write-Host "  Transformed page: " $result -ForegroundColor Green

            }else{
                Write-Host "  Page not transformed, check the logs for issues" -ForegroundColor Red
            }
        }
    }

    # Write the logs to the folder
    Save-PnPClientSidePageConversionLog

    Write-Host "Script Complete! :)" -ForegroundColor Green
}