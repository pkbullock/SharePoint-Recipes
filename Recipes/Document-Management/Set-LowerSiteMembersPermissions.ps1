# ----------------------------------------------------------------------------
# Lowers the permissions for site members
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

# PnP Online Connection
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$Url,
    [switch]$RestorePermission
)
begin{

    # PnP Online Connection, check if already connecteds
    if((Get-PnPConnection).Url -ne $Url){
        Connect-PnPOnline -Url $Url -NoTelemetry
    }

}
process {
    
    $membersGroup = Get-PnPGroup -AssociatedMemberGroup
    
    if($RestorePermission){
        # Update permissions to prevent users from creating or deleting lists/libraries
        Set-PnPGroupPermissions -Identity $membersGroup -RemoveRole "Contribute" -AddRole "Edit"
    }else{
        # Update permissions to prevent users from creating or deleting lists/libraries
        Set-PnPGroupPermissions -Identity $membersGroup -RemoveRole "Edit" -AddRole "Contribute"
    }

    Write-Host "Script Complete! :)" -ForegroundColor Green

}