# ----------------------------------------------------------------------------
# Updating site column with custom formatting
# Created:      Paul Bullock
#               2018 CaPa Creative Ltd
# Date:         05/02/2018s
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
# ----------------------------------------------------------------------------


# Connect to SharePoint
Connect-PnPOnline -Url 'https://<tenant>.sharepoint.com/sites/DemoColumnFormatting' -ErrorAction Stop

$field = Get-PnPField -Identity "Demo Sensitivity"

# Update field using internal name
$field | Set-PnPField -UpdateExistingLists `
    -Values @{CustomFormatter= @'
    {
        "$schema": "http://columnformatting.sharepointpnp.com/columnFormattingSchema.json",
        "elmType": "div",
        "attributes": {
            "class": {
                "operator": "?",
                "operands": [
                    {
                        "operator": "==",
                        "operands": [
                            {
                                "operator": "toString()",
                                "operands": [
                                    "@currentField"
                                ]
                            },
                            "Official"
                        ]
                    },
                    "sp-field-severity--good",
                    {
                        "operator": "?",
                        "operands": [
                            {
                                "operator": "==",
                                "operands": [
                                    {
                                        "operator": "toString()",
                                        "operands": [
                                            "@currentField"
                                        ]
                                    },
                                    "Official-Sensitive"
                                ]
                            },
                            "sp-field-severity--low",
                            {
                                "operator": "?",
                                "operands": [
                                    {
                                        "operator": "==",
                                        "operands": [
                                            {
                                                "operator": "toString()",
                                                "operands": [
                                                    "@currentField"
                                                ]
                                            },
                                            "Secret"
                                        ]
                                    },
                                    "sp-field-severity--warning",
                                    {
                                        "operator": "?",
                                        "operands": [
                                            {
                                                "operator": "==",
                                                "operands": [
                                                    {
                                                        "operator": "toString()",
                                                        "operands": [
                                                            "@currentField"
                                                        ]
                                                    },
                                                    "Top Secret"
                                                ]
                                            },
                                            "sp-field-severity--severeWarning",
                                            "sp-field-severity--blocked"
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        },
        "children": [
            {
                "elmType": "span",
                "style": {
                    "display": "inline-block",
                    "padding": "0 4px"
                }
                
            },
            {
                "elmType": "span",
                "txtContent": "@currentField"
            }
        ]
    }
'@
}


