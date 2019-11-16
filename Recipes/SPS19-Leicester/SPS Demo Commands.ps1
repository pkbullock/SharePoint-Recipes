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
    Simple run through Step by Step

.Notes

    Useful references:
        - https://github.com/SharePoint/sp-dev-modernization
        - https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/convertto-pnpclientsidepage?view=sharepoint-ps
        - https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/?view=sharepoint-ps
        
#>

# Show the cmdlets
Get-Help ConvertTo-PnPClientSidePage

#--------------------------------
# Wiki Page Commands
# Note: This was dropped from demo due to time constraints
#--------------------------------

#Connections
$sp13ConnTeamSite = Connect-PnPOnline http://2013/sites/teamsite -ReturnConnection
$spOnlineConn = Connect-PnPOnline https://contoso.sharepoint.com/sites/PnPKatchup -ReturnConnection

ConvertTo-PnPClientSidePage -Identity "Demo-PageTransform-Architecture.aspx" -TargetConnection $spOnlineConn -Connection $sp13ConnTeamSite -Overwrite -LogType Console -UserMappingFile "$(Get-Location)\MappingFiles\usermapping.csv" -SetAuthorInPageHeader -DisablePageComments

ConvertTo-PnPClientSidePage -Identity "Demo-URL-Mapping.aspx" -TargetConnection $spOnlineConn -Connection $sp13ConnTeamSite -Overwrite -LogType Console -UserMappingFile "$(Get-Location)\MappingFiles\usermapping.csv" -SetAuthorInPageHeader -DisablePageComments

#-----------------------------
# Publishing Portal Commands
#-----------------------------

$sp13Conn = Connect-PnPOnline http://2013/en -Credentials OnPrem -ReturnConnection
$spOnlineConn = Connect-PnPOnline https://contoso.sharepoint.com/sites/PnPKatchup -Credentials Online -ReturnConnection

# Exporting Page Layout File
#------------------------------
# Example based on a page
Export-PnPClientSidePageMapping -CustomPageLayoutMapping -PublishingPage "Quality-Cherry-Cake.aspx" -Folder "C:\temp" -Connection $sp13Conn
# Example based to export all the layouts
Export-PnPClientSidePageMapping -CustomPageLayoutMapping -Folder "C:\temp" -Connection $sp13Conn -BuiltInWebPartMapping


# Transforming Page based on Exported Content
#-----------------------------------------------

# The export generated a file, which can be tweaked to adjust the layout of the page
ConvertTo-PnPClientSidePage -Identity "Quality-Cherry-Cake.aspx" -PublishingPage -TargetConnection $spOnlineConn -Connection $sp13Conn -Overwrite -LogType Console -PageLayoutMapping C:\temp\custompagelayoutmapping-f3629db3-3e4d-48c4-b904-6fffab6dbb65-quality-cherry-cake.xml -UserMappingFile "$(Get-Location)\MappingFiles\usermapping.csv" -KeepPageCreationModificationInformation


<#

# Run through each step as a demo of the tweaks to mapping file.

Rename mapping file to custompagelayoutmapping-recipes.xml

# Add to mapping file
<SectionEmphasis>
<Section Row="3" Emphasis="Neutral" />
</SectionEmphasis>

# Adjust header for static string:

StaticString('https://contoso.sharepoint.com/sites/PnPKatchup/SiteAssets/Images/christmas-banner.jpg')
Type to "ColorBlock"

# Add for Thumbnail
<Field Name="PublishingPageImage" TargetFieldName="BannerImageUrl" Functions="ToPreviewImageUrl({PublishingPageImage})" />

#>