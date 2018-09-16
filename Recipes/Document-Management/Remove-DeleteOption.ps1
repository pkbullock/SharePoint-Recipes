# ----------------------------------------------------------------------------
# Removes the delete option from SharePoint UI

# Created:      Paul Bullock
# Copyright (c) 2018 CaPa Creative Ltd
# Date:         14/09/2018
# License:      MIT License (MIT)

# Disclaimer:   
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Useful reference: https://capa.ltd/pnp-posh-docs

# ----------------------------------------------------------------------------


[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Url,
    [Parameter(Mandatory = $true)]
    [string]$LibraryTitle,
    [Parameter(Mandatory = $false)]
    [switch]$EnableDeletion = $false
)
process {

    # PnP Online Connection
    if((Get-PnPConnection).Url -ne $Url){
        Connect-PnPOnline -Url $Url -NoTelemetry
    }

    $list = Get-PnPList -Identity $LibraryTitle
    if($list){

        $list.AllowDeletion = $EnableDeletion
        $list.Update()
        Invoke-PnPQuery
        Write-Host "Updated settings"    

    }else{
        
        Write-Host "List not found!"

    }

    Write-Host "Script Complete! :)" -ForegroundColor Green
}
