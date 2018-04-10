# ----------------------------------------------------------------------------
# Example to deploy app to a site collection from the tenant catalog
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

# Useful reference: https://github.com/SharePoint/PnP-PowerShell/blob/master/Documentation/readme.md

# ----------------------------------------------------------------------------

# SPO Sample
# This sample is using Windows Credentials
$cred = Get-Credential -UserName '<User>@<Tenant>.onmicrosoft.com' -Message "Enter SPO credentials"

# PnP
Connect-PnPOnline -Url https://<tenant>-admin.sharepoint.com -Credentials $cred

# Not Available yet on this tenant 

#Apps Catalog Url - Add-PnPApp -Path ./myapp.sppkg"

# Gets the available app
Get-PnPApp


$siteUrl = "https://<tenant>.sharepoint.com"
#$cred = Get-Credential -UserName '<User>@<Tenant>.onmicrosoft.com' -Message "Enter SPO credentials"
Connect-PnPOnline -Url $siteUrl -Credentials $cred

# Installing the app
#Install-PnPApp -Identity $appId

# Updating the app
#Update-PnPApp -Identity $appId

# Removing the app
#Uninstall-PnPApp -Identity $appId