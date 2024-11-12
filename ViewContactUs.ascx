<%@ Control Language="C#" Inherits="Webtech4rindia.Modules.ContactUs.ViewContactUs"
    CodeFile="ViewContactUs.ascx.cs" AutoEventWireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="Telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<script type="text/javascript">
    function Disable() {
        var isValid = true;
        var ele = document.getElementById("<%=txtName.ClientID %>").value;
        var ele1 = document.getElementById("<%=txtLastName.ClientID %>").value;
        var ele2 = document.getElementById("<%=txtPhone.ClientID %>").value;
        var ele3 = document.getElementById("<%=txtEmail.ClientID %>").value;
        var ele4 = document.getElementById("<%=txtReemail.ClientID %>").value;
        var ele5 = document.getElementById("<%=txtSalonName.ClientID %>").value;
        var ele6 = document.getElementById("<%=txtAddress.ClientID %>").value;
        var ele7 = document.getElementById("<%=txtCity.ClientID %>").value;
        var ele8 = document.getElementById("<%=txtZipCode.ClientID %>").value;
        if (ele == "" || ele1 == "" || ele2 == "" || ele3 == "" || ele4 == "" || ele5 == "" || ele6 == "" || ele7 == "" || ele8 == "")
            isValid = false;
        if (isValid) {
            document.getElementById("<%=btnSubmit.ClientID %>").style.display = "none";
            document.getElementById("Loder").style.display = "block";
        }
        return false;
    }
</script>
 
<style type="text/css">
    .labelspan {
        color: black;
        float: left;
        font-size: 14px;
        line-height: 24px;
        padding-top: 13px;
        
        /* padding-bottom: 13px; */
    }
.RadInput_Default .riTextBox,.RadInputMgr_Default {
border-color: gray!important;
background: #fff;
font: 13px sans-serif!important;
color: black!important;
}
    .slogn {
        font-size: 20px;
        color: #1FB25A;
        text-shadow: 1px 1px 1px #565656;
        border-bottom: 1px solid #404041;
        padding-bottom: 9px;
        margin-bottom: 9px;
    }

    .mGrid {
        width: 100%;
        background-color: #fff;
        margin: 20px 0 10px 0;
        border: solid 1px #525252;
        border-collapse: collapse;
    }
.mGrid span{line-height:18px;}
.hcolor{ color:#404041;}
        .mGrid td {
            padding: 2px;
            border: solid 1px #c1c1c1;
            color: #1fb25a;
           vertical-align: middle;
        }

        .mGrid th {
            padding: 4px 2px;
            color: #fff;
            font-family: 'Nixie One', cursive;
            background: #B9B4AE repeat-x top;
            font-size: 14px;
        }

        .mGrid .pgr td {
            border-width: 0;
            padding: 0 6px;
            border-left: solid 0px #666;
            font-weight: bold;
            color: #fff;
            line-height: 12px;
        }
        .riContSpinButtons{width: 60px!important;}
.mGrid td {padding-left:5px;}
    .Require {
        color: red;
    }
</style>
<asp:UpdatePanel ID="uppanel" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ddPosition" />
        <asp:AsyncPostBackTrigger ControlID="btnSubmit" />
    </Triggers>
    <ContentTemplate>
        <asp:Panel ID="pnlInfo" runat="server">
            <table cellpadding="4" cellspacing="4" border="1" width="800px" style="float:left;margin-left:10px;">
                <tr>
                    <td valign="top" colspan="2" align="center">

                        <asp:GridView ID="grdWishlist" runat="server" GridLines="None"
                            AllowPaging="true"
                            CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            AlternatingRowStyle-CssClass="alt" AutoGenerateColumns="false" Width="710px" OnRowDeleting="grdWishlist_RowDeleting" OnRowDataBound="grdWishlist_RowDataBound" OnRowCommand="grdWishlist_RowCommand" OnRowDeleted="grdWishlist_RowDeleted">
                            <Columns>
                                <asp:TemplateField HeaderText="IMAGE" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <p style="margin: 10px">
                                            <asp:ImageButton ID="productImage" runat="server" ImageUrl='<%#Eval("ImageURL") %>' Width="50" Height="50" />
                                        </p>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="QUANTITY" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <Telerik:RadNumericTextBox ShowSpinButtons="true" ID="radQuantity" Width="80" Height="40" NumberFormat-DecimalDigits="0" runat="server" MinValue="1" MaxLength="4" MaxValue="999"></Telerik:RadNumericTextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NAME" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblProductName" runat="server" Text='<%#Eval("ProductName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DESCRIPTION" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Top" HeaderStyle-HorizontalAlign="Center" >
                                    <ItemTemplate>
                                        <asp:Label ID="lblProductDes" runat="server" CssClass="hcolor" Text='<%#GetDescription(Eval("Description").ToString()) %>'></asp:Label>
                                        <asp:Label ID="lblProductId" runat="server" Text='<%#Eval("ProductID") %>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="REMOVE" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgDelete" runat="server" ImageUrl="~/images/delete.gif" CommandArgument='<%#Eval("ProductID") %>' CommandName="delete" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </td>

                </tr>
                <tr>
                    <td valign="top" colspan="2" style="margin-left: 10px;" align="left">
                        
                      
                        <h2>Submit My Request</h2>
<%--                     <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="Req" ValidationGroup="A" Display="Dynamic" ShowMessageBox="true" ShowSummary="true" DisplayMode="List" ForeColor="Red" HeaderText="MISSING: Please provide following information as well.">
        </asp:ValidationSummary>--%>
       <br />
               <span style="font-size: 14px; color:black;">(Mandatory fields marked with an asterisk <span style="color: red;">*</span>)</span>


                    </td>

                </tr>
                <tr>
                    <td valign="top" align="left" style="width:50%;">

                        <table cellpadding="10" cellspacing="10" border="0">
                            <tr>
                                <td valign="top" nowrap="Nowrap">

                                    <asp:Label ID="lblName" runat="server" Text="" CssClass="labelspan">First Name <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top">

                                    <asp:TextBox ID="txtName" runat="server" MaxLength="50" Width="200" TabIndex="1" Height="35px"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="ReqfName" runat="server" ControlToValidate="txtName"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" First Name is required." ErrorMessage="First Name can't be blank"
                                        >
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" align="right">
                                    <asp:Label ID="lblDescription" runat="server" CssClass="labelspan">Last Name <span class="Require">*</span></asp:Label>
                                </td>
                                <td valign="top" align="left">
                                    <asp:TextBox ID="txtLastName" TabIndex="2" AutoCompleteType="LastName" runat="server" MaxLength="50" Width="200" Height="35px"></asp:TextBox><br />

                                    <asp:RequiredFieldValidator ID="Reqdescription" runat="server" ControlToValidate="txtLastName"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" Last Name is required." ErrorMessage="Last Name can't be blank" >
                     
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" nowrap="nowrap" align="right">

                                    <asp:Label ID="lblPhoneNo" runat="server" CssClass="labelspan">Phone <span class="Require">*</span></asp:Label>
                                </td>
                                <td valign="top" align="left">
                                    <asp:TextBox ID="txtPhone" AutoCompleteType="BusinessPhone" TabIndex="3" runat="server" MaxLength="20" Width="200" Height="35px"></asp:TextBox><br />

                                    <asp:RequiredFieldValidator ID="ReqFMsg" runat="server" ControlToValidate="txtPhone"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" Phone is required."  ErrorMessage="Phone can't be blank">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">

                                    <asp:Label ID="lblEmail" runat="server" CssClass="labelspan">Email <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtEmail" AutoCompleteType="Email" TabIndex="4" runat="server" MaxLength="100" Width="200" Height="35px"></asp:TextBox><br />


                              <asp:RequiredFieldValidator ID="ReqFEmail" runat="server" ControlToValidate="txtEmail"
                                CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" Email is required."  ErrorMessage="Email can't be blank">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegEEmail" runat="server" ControlToValidate="txtEmail"
                                CssClass="Req" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ValidationGroup="A" ErrorMessage="Email isn't in valid format">   
                            </asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" align="left" nowrap="nowrap">
                                    <asp:Label ID="lblRetypeEmail" runat="server" CssClass="labelspan">Re-Type Email <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top" align="left">
                                    <asp:TextBox ID="txtReemail" AutoCompleteType="Email" TabIndex="5" runat="server" MaxLength="100" Width="200" Height="35px"></asp:TextBox><br />


                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtReemail"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" Email is required.">
                                    </asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator1" ControlToCompare="txtEmail" CssClass="Req" ControlToValidate="txtReemail" Display="Dynamic" ValidationGroup="A" runat="server" Text="Email / Re-type email need to be same."></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" align="left">
                                    <asp:Label ID="lblPosition" runat="server" Text="Position" CssClass="labelspan"></asp:Label>
                                </td>
                                <td valign="top" align="left">

                                    <asp:DropDownList ID="ddPosition" runat="server" TabIndex="6" CssClass="NormalTextBox" AutoPostBack="true" OnSelectedIndexChanged="ddPosition_SelectedIndexChanged" Width="200" Height="35px">
                                        <asp:ListItem Selected="True" Text="- Select - " Value="-1"></asp:ListItem>
                                        <asp:ListItem Text="Owner" Value="Owner"></asp:ListItem>
                                        <asp:ListItem Text="Manager" Value="Manager"></asp:ListItem>
                                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtpositionOther" Width="200" Height="35px" runat="server" Visible="false" MaxLength="50"></asp:TextBox>


                                </td>
                            </tr>


                        </table>
                    </td>

                    <td valign="top" align="left">

                        <table cellpadding="4" cellspacing="4">
                            <tr>
                                <td valign="top" nowrap="nowrap">
                                    <asp:Label ID="lblSpaName" runat="server" CssClass="labelspan">Salon/Spa Name <span class="Require">*</span></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtSalonName" runat="server" MaxLength="50" TabIndex="7" Width="200" Height="35px"></asp:TextBox><br />

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSalonName"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" Salon/Spa is required."  ErrorMessage="Salon/Spa can't be blank">
                                    </asp:RequiredFieldValidator>

                                </td>
                            </tr>

                            <tr>
                                <td valign="top">

                                    <asp:Label ID="lblAddress" runat="server" CssClass="labelspan">Address <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtAddress" runat="server" MaxLength="100" TabIndex="8" Width="200" Height="35px"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAddress"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" Address is required."  ErrorMessage="Address can't be blank">
                                    </asp:RequiredFieldValidator>

                                </td>
                            </tr>

                                <tr>
                                <td valign="top" align="right">
                                    <asp:Label ID="lblCity" runat="server" CssClass="labelspan">City <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top" align="left">
                                    <asp:TextBox ID="txtCity" AutoCompleteType="BusinessCity" TabIndex="9" runat="server" MaxLength="50" Width="200" Height="35px"></asp:TextBox><br />


                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCity"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" City is required."  ErrorMessage="City can't be blank">
                                    </asp:RequiredFieldValidator>

                                </td>
                            </tr>

                         
                            <tr>
                                <td valign="top" nowrap="nowrap" align="right">
                                    <asp:Label ID="Label1" runat="server" CssClass="labelspan">State/Province <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top" align="left">
                                    <asp:DropDownList ID="ddStates" Width="200" Height="35px" TabIndex="10" runat="server"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblZipCode" runat="server" CssClass="labelspan">Zip/Postal Code <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtZipCode" AutoCompleteType="BusinessZipCode" TabIndex="11" runat="server" MaxLength="6" Width="200" Height="35px"></asp:TextBox><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtZipCode"
                                        CssClass="Req" Display="Dynamic" ValidationGroup="A" Text=" Zip/Postal is required."  ErrorMessage="Zip/Postal Code can't be blank">
                                    </asp:RequiredFieldValidator>

                                </td>
                            </tr>
                               <tr>
                                <td valign="top">
                                    <asp:Label ID="Label2" runat="server" CssClass="labelspan">Country <span class="Require">*</span></asp:Label>

                                </td>
                                <td valign="top">

                                    <asp:DropDownList ID="ddCountry" runat="server" Width="200" TabIndex="12" Height="35px" AutoPostBack="true" OnSelectedIndexChanged="ddCountry_SelectedIndexChanged">

                                        <asp:ListItem Selected="True" Text="Canada" Value="36"></asp:ListItem>
                                        <asp:ListItem Text="USA" Value="221"></asp:ListItem>

                                    </asp:DropDownList>

                                </td>
                            </tr>
                        </table>
                    </td>

                </tr>

                <tr>
                    <td valign="top" colspan="2">
                        <asp:CheckBox ID="chkNewsletter" CssClass="labelspan" TabIndex="13" runat="server" Checked="true" Text="Yes, I would like to receive e‐mails from time to time at the above e‐mail address." />
                    </td>
                </tr>

                <tr>
                    <td valign="top" colspan="2" style="margin-left: 80px">
                        <asp:CheckBox ID="chkTerms" runat="server" CssClass="labelspan" TabIndex="14" Text="Yes, I am interested in " />
                        <span class="labelspan"><a href="/novoq/Design.aspx" target="_blank" style="color:blue; margin-left:5px;">Design Services</a>.</span>
                    </td>
                </tr>
                <tr>

                    <td valign="top" colspan="2" style="margin-left: 80px">
                        <asp:Label ID="lblAdditionalQuestion" runat="server" Text="Additional Comments or Questions" CssClass="labelspan"></asp:Label>
                        <Telerik:RadTextBox ID="txtAdditionalQuestion" TabIndex="15" CssClass="NormalTextBox" runat="server" MaxLength="1000"
                            Width="708px" Rows="10" TextMode="MultiLine">
                        </Telerik:RadTextBox>
                    </td>
                </tr>


                <tr>
                    <td valign="top" colspan="2" align="center">
                        <br />
                        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" OnClientClick="Disable()"
                            Text="Submit for Quotes" ValidationGroup="A" TabIndex="16" CssClass="banner-button-inner" />
                        <div id="Loder" style="display:none" >
                            <img src='<%=ModulePath %>ajax.gif' />
                        </div>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnlConfirmation" runat="server" Visible="false">
            <p style="width: 100%; text-align: center;">
                <b>
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </b>
            </p>
        </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
