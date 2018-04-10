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

# This sample is using Windows Credentials
$cred = Get-Credential -UserName '<User>@<Tenant>.onmicrosoft.com' -Message "Enter SPO credentials"

# Add your app to the tenant catalog
$adminUrl = "https://<tenant>-admin.sharepoint.com"
Connect-PnPOnline -Url $adminUrl -Credentials $cred

# Upload app to your tenant
Write-Host "Finding app to tenant..."
$apps = Get-PnPApp 
$app = $apps | Where-Object Title -eq "search-wp-spfx-client-side-solution"  | Select-Object Id

# Example of removing an app
Write-Host "Removing app in tenant..."
Remove-PnPApp -Identity $app.Id

# Gets the available app
Write-Host "Listing all apps..."
Get-PnPApp

Write-Host "Complete" -ForegroundColor Green