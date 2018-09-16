# ----------------------------------------------------------------------------
# Setup demo for lists with custom formatting
# Created:      Paul Bullock
#               2018 CaPa Creative Ltd
# Date:         05/02/2018
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
# Useful reference: https://capa.ltd/pnp-posh-docs
#
# ----------------------------------------------------------------------------


# Connect to SharePoint
Connect-PnPOnline -Url 'https://<tenant>/sites/DemoColumnFormatting' -ErrorAction Stop

# Setup for example
# --------------------

# Xml Definition for Site Column
$xml = @'
<Field Type="Choice" Name="demo_sensitivity" 
    DisplayName="Demo Sensitivity" 
    ID="{7931e8f5-e9c2-4f88-bf45-fbcd53fbd042}" 
    Group="Demo Columns" 
    Required="FALSE" 
    StaticName="demo_sensitivity">
        <CHOICES>
            <CHOICE>Official</CHOICE>
            <CHOICE>Official-Sensitive</CHOICE>
            <CHOICE>Secret</CHOICE>
            <CHOICE>Top Secret</CHOICE>
        </CHOICES>
    </Field>
'@

# Add column to the site
Add-PnPFieldFromXml -FieldXml $xml

# This is an example library
# Add Library
New-PnPList -Title "Demo Library" -Url "demolibrary" -Template DocumentLibrary

# Add Site Column To Library
$list = Get-PnPList -Identity "Demo Library"
$field = Get-PnPField -Identity "Demo Sensitivity"

Add-PnPField -List $list -Field $field