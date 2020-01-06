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
    $content = ""

    $content = $content + "# Reference Ids for the Learning Portal Content Pack Creation `n`n"
    $content = $content + "## List of Technologies and Subjects `n`n"
    
    $content = $content + "`n| Id | Name | Subjects | `n"
    $content = $content + "|------|------|---------| `n"
    $Manifest.Technologies | Foreach-Object {

        $content = $content + "| $($_.Id) | $($_.Name) | "
        if($_.Subjects){
            $content = $content + "<table><thead><tr><th>Id</th><th>Name</th></tr></thead><tbody>"
            $_.Subjects | ForEach-Object {
                $content = $content + "<tr><td>" + $_.Id + "</td><td>" + $_.Name + "</td></tr>"
            }
            $content = $content + "</tbody></table> | "
        }
        $content = $content + "`n"
    }
    
    $content = $content + "`n`n## List of Categories and Sub Categories`n`n"
    
    $content = $content + "`n| Id | Name | Sub Categories | `n"
    $content = $content + "|------|------|---------| `n"
    $Manifest.Categories | Foreach-Object {

        $content = $content + "| $($_.Id) | $($_.Name) | "
        
        if($_.SubCategories){
            $content = $content + "<table><thead><tr><th>Id</th><th>Name</th></tr></thead><tbody>"
            $_.SubCategories | ForEach-Object {
                $content = $content + "<tr><td>" + $_.Id + "</td><td>" + $_.Name + "</td></tr>"
            }
            $content = $content + "</tbody></table> | "
        }
        $content = $content + "`n"
    }
    
    $content = $content + "`n`n## List of Audiences`n`n"
    
    $content = $content + "| Id | Name |`n"
    $content = $content + "|----|------|`n"
    
    $Manifest.Audiences | Foreach-Object {
        $content = $content + "| " +  $_.Id + " | " + $_.Name + " | `n"
    }

    $content = $content + "`n`n## List of Levels`n`n"
    $content = $content + "| Id | Name |`n"
    $content = $content + "|----|------|`n"
    $Manifest.Levels | Foreach-Object {
        $content = $content + "| " + $_.Id + " | " + $_.Name + " | `n"
    }

    $content = $content + "`n`n## List of Status Tag`n`n"
    $content = $content + "| Id | Name |`n"
    $content = $content + "|----|------|`n"
    $Manifest.StatusTag | Foreach-Object {
        $content = $content + "| " + $_.Id + " | " + $_.Name + " |`n"
    }

    $content

}
end{
    $content | Out-File -FilePath "$(Get-Location)/learning-portal-references.md" -Force
}