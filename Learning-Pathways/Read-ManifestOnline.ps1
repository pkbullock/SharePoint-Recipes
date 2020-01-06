<# 
----------------------------------------------------------------------------

Created:      Paul Bullock
Copyright (c) 2019 CaPa Creative Ltd
Date:         06/01/2020
Disclaimer:   

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

.Synopsis

.Example

.Notes

Useful reference: 
      List any useful references

 ----------------------------------------------------------------------------
#>

[CmdletBinding()]
param (
    $ManiFestUrl = "https://pnp.github.io/custom-learning-office-365/learningpathways/v3/metadata.json"
)
begin{

  Write-Host @"
  _________      ________            _________                  __________                  ______ ______________
  __  ____/_____ ___  __ \_____ _    __  ____/_________________ __  /___(_)__   ______      ___  / __  /______  /
  _  /    _  __ `/_  /_/ /  __ `/    _  /    __  ___/  _ \  __ `/  __/_  /__ | / /  _ \     __  /  _  __/  __  / 
  / /___  / /_/ /_  ____// /_/ /     / /___  _  /   /  __/ /_/ // /_ _  / __ |/ //  __/     _  /___/ /_ / /_/ /  
  \____/  \__,_/ /_/     \__,_/      \____/  /_/    \___/\__,_/ \__/ /_/  _____/ \___/      /_____/\__/ \__,_/   
                                                                                                                 
"@

}
process {

    Write-Host "Getting Manifest.json from PnP CDN"
    $Manifest = Invoke-WebRequest $ManiFestUrl | Select-Object -Expand Content | ConvertFrom-Json

    Write-Host "List of Technologies and Subjects" -ForegroundColor Cyan
    $Manifest.Technologies | Foreach-Object {

        Write-Host $_.Id $_.Name -ForegroundColor Green

        if($_.Subjects){

            $_.Subjects | ForEach-Object {

                Write-Host '  Subject: ' $_.Id $_.Name
            }
        }
    } 

}
end{

}