# ----------------------------------------------------------------------------
# This is a example for adding a SPO theme to SharePoint tenant
# Created:      Paul Bullock
# Copyright (c) 2016 CaPa Creative Ltd
# Date:         05/10/2017
# License:      MIT License (MIT)
# Disclaimer:   
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Useful reference: https://docs.microsoft.com/en-us/sharepoint/dev/declarative-customization/site-theming/sharepoint-site-theming-powershell#add-spotheme
#
# ----------------------------------------------------------------------------

Write-Host "Running script..." -ForegroundColor Green

# Get your credentials
$cred = Get-Credential -UserName '<User>@<Tenant>.onmicrosoft.com' -Message "Enter SPO credentials"

#Connect to SPO Admin
Connect-SPOService -Url 'https://<yourtenant>-admin.sharepoint.com' -Credential $cred

function HashToDictionary {
    Param ([Hashtable]$ht)
    $dictionary = New-Object "System.Collections.Generic.Dictionary``2[System.String,System.String]"
    foreach ($entry in $ht.GetEnumerator()) {
      $dictionary.Add($entry.Name, $entry.Value)
    }
    return $dictionary
}

# Theme Generator site
# Url: https://developer.microsoft.com/en-us/fabric#/styles/themegenerator  
$ThemePalette = HashToDictionary(
    @{
        "themePrimary" = "#ff69b4";
        "themeLighterAlt" = "#fff7fb";
        "themeLighter" = "#fff0f7";
        "themeLight" = "#ffe1f0";
        "themeTertiary" = "#ffc0df";
        "themeSecondary" = "#ff78bb";
        "themeDarkAlt" = "#ff45a2";
        "themeDark" = "#fc007e";
        "themeDarker" = "#c60063";
        "neutralLighterAlt" = "#f8f8f8";
        "neutralLighter" = "#f4f4f4";
        "neutralLight" = "#eaeaea";
        "neutralQuaternaryAlt" = "#dadada";
        "neutralQuaternary" = "#d0d0d0";
        "neutralTertiaryAlt" = "#c8c8c8";
        "neutralTertiary" = "#d6d6d6";
        "neutralSecondary" = "#474747";
        "neutralPrimaryAlt" = "#2e2e2e";
        "neutralPrimary" = "#333333";
        "neutralDark" = "#242424";
        "black" = "#1c1c1c";
        "white" = "#ffffff";
        "primaryBackground" = "#ffffff";
        "primaryText" = "#333333";
        "bodyBackground" = "#ffffff";
        "bodyText" = "#333333";
        "disabledBackground" = "#f4f4f4";
        "disabledText" = "#c8c8c8";
    }
)
  
  # Adds Theme to the tenant, Use -overwrite to update theme 
  Add-SPOTheme -Name "Hot Pink" -Palette $ThemePalette -IsInverted $false 

  # Hide default themes
  # Set-HideDefaultThemes $true

  # Restore Default Themes
  # Set-HideDefaultThemes $true
  
  # Gets all themes
  #Get-SPOTheme

  # Removes custom theme
  #Remove-SPOTheme -Name "Custom Theme Name"
  
  Write-Host "Done! :)" -ForegroundColor Green
  