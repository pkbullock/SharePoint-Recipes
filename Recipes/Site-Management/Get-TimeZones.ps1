# 
# Get Timezone codes for Site collection creation
# Created:      Paul Bullock
# Date:         18/09/2017
# Copyright (c) 2016 CaPa Creative Ltd
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
# Useful reference: https://github.com/SharePoint/PnP-PowerShell/blob/master/Documentation/readme.md
#
[CmdletBinding()]
param (
)
process {

    $tz = Get-PnPTimeZoneId

    Write-Host "| ID | Description | Difference |"
    Write-Host "|----|-------------|------------|"

    $tz | foreach-object{ "| $($_.Id) | $( (Get-Culture).TextInfo.ToTitleCase($_.Description.ToLower())) | $($_.Identifier) |"} 

    Write-Host "Complete" -ForegroundColor Green

}