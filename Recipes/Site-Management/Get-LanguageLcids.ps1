<# ----------------------------------------------------------------------------

Gets Language LCIDs

Created:      Paul Bullock
Copyright (c) 2020 CaPa Creative Ltd
Date:         16/09/2018
License:      MIT License (MIT)

Disclaimer:   

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Useful reference: https://capa.ltd/pnp-posh-docs

---------------------------------------------------------------------------- #>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Url
)
begin{

    # PnP Online Connection, check if already connected
    Connect-PnPOnline -Url $Url -NoTelemetry -UseWebLogin
}
process {
    
    $languages = (Get-PnPWeb -Includes RegionalSettings.InstalledLanguages).RegionalSettings.InstalledLanguages | `
        Sort-Object -Property "DisplayName"

    Write-Host "| Name | Language Tag | LCID |"
    Write-Host "|----|-------------|------------|"

    $languages | foreach-object{ "| $($_.DisplayName) | $($_.LanguageTag) | $($_.LCID) |"} 


    Write-Host "Script Complete! :)" -ForegroundColor Green
    
}