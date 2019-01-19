# ----------------------------------------------------------------------------
# Set 404 on a modern site
#
# Created:      Paul Bullock
# Copyright (c) 2018 CaPa Creative Ltd
# Date:         16/09/2018
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

# Connect to SharePoint Online with PnP PowerShell library

$tenant = "capadev"
$site = "signpost"


$siteUrl = "https://$($tenant).sharepoint.com/sites/$($site)"

Write-Host "Removing 404 page setting at $($siteUrl)..."

Connect-PnPOnline $siteUrl

# Disable NoScript
Write-Host "  Disabling NoScript" -ForegroundColor Cyan
Set-PnPTenantSite -Url $siteUrl -NoScriptSite:$false

# Sets the value in the property bag, note: ensure you have disabled NoScript
Write-Host "  Removing Property Bag Key" -ForegroundColor Cyan
Remove-PnPPropertyBagValue -Key "vti_filenotfoundpage"

# Enable NoScript
Write-Host "  Enabling NoScript" -ForegroundColor Cyan
Set-PnPTenantSite -Url $siteUrl -NoScriptSite

Write-Host "Script Complete! :)" -ForegroundColor Green
