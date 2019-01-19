# ----------------------------------------------------------------------------
# Set 404 on a modern site
#
# Created:      Paul Bullock
# Copyright (c) 2018 CaPa Creative Ltd
# Date:         19/01/2019
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

$tenant = "<tenant>"
$site = "<site>"

$siteUrl = "https://$($tenant).sharepoint.com/sites/$($site)"

Write-Host "Setting 404 page at $($siteUrl)..."

# Connect to SharePoint Online with PnP PowerShell library
Connect-PnPOnline $siteUrl

# Disable NoScript
Write-Host "  Disabling NoScript" -ForegroundColor Cyan
Set-PnPTenantSite -Url $siteUrl -NoScriptSite:$false

# Sets the value in the property bag, note: ensure you have disabled NoScript
Write-Host "  Adding Property Bag Key" -ForegroundColor Cyan
Set-PnPPropertyBagValue -Key "vti_filenotfoundpage" -Value "/sites/$($site)/SitePages/Page-not-found.aspx"

# Enable NoScript
Write-Host "  Enabling NoScript" -ForegroundColor Cyan
Set-PnPTenantSite -Url $siteUrl -NoScriptSite

Write-Host "Script Complete! :)" -ForegroundColor Green
