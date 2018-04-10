# ----------------------------------------------------------------------------
# Example to deploy a SPFx package to the tenant app catalog
# Created:      Paul Bullock
# Copyright (c) 2017 CaPa Creative Ltd
# Date:         17/11/2017
# License:      MIT License (MIT)
# Disclaimer:   

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Useful reference: 
#   https://github.com/SharePoint/PnP-PowerShell/blob/master/Documentation/readme.md
#   https://docs.microsoft.com/en-us/sharepoint/dev/apis/alm-api-for-spfx-add-ins 
# ----------------------------------------------------------------------------

# Deploying your app to the app catalog
#----------------------------------------

$cred = Get-Credential -UserName '<User>@<Tenant>.onmicrosoft.com' -Message "Enter SPO credentials"

# Add your app to the tenant catalog
$adminUrl = "https://<tenant>-admin.sharepoint.com"
Connect-PnPOnline -Url $adminUrl -Credentials $cred

# Upload app to your tenant
Write-Host "Uploading app to tenant..."
$appId = Add-PnPApp -Path "./search-wp-spfx.spapp"


Write-Host "Publishing app..."

# Note: Use the SkipFeatureDeployment flag to allow an app that was developed for 
# tenant wide deployment to be actually available as a tenant wide deployed app.
# -SkipFeatureDeployment
Publish-PnPApp -Identity $appId 

# Example of removing an app
#Remove-PnPApp -Identity $appId

Write-Host "Listing all apps..."

# Gets the available app
Get-PnPApp


Write-Host "Complete" -ForegroundColor Green