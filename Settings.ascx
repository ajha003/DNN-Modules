<%@ Control Language="C#" AutoEventWireup="false" Inherits="Webtech4rindia.Modules.ContactUs.Settings" CodeFile="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<div id="divAdminsection">
    <h2 id="dnnSitePanel-Module" class="dnnFormSectionHead">
        <a href="" class="dnnSectionExpanded"><%=Localization.GetString("AdminMail.Text", LocalResourceFile)%></a>
    </h2>
    <fieldset>
        <table cellspacing="5" cellpadding="2" border="0" width="680px">

            <tr>
                <td>
                    <dnn:Label ID="lblSentForm" runat="server" Suffix=":" ControlName="lblSentForm" />
                </td>
                <td>
                    <asp:TextBox ID="txtReplyto" Width="300" runat="server" MaxLength="200"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvSMTPUser" runat="server" ControlToValidate="txtReplyto" SetFocusOnError="true" Display="Dynamic"
                        Enabled="false"><%= LocalizeString("MsgRequired.Text")%></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revSMTPUserEmail" CssClass="NormalRed" Display="Dynamic" SetFocusOnError="true"
                        runat="server" ControlToValidate="txtReplyto" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ErrorMessage="SMTP Username should be yourname@yourdomain.com"></asp:RegularExpressionValidator>
                </td>
            </tr>

        </table>
        <table cellspacing="5" cellpadding="2" border="0">
            
            <tr>
                <td class="SubHead" valign="top">
                    <dnn:Label ID="lblAdminEmailSubject" runat="server" ControlName="lblAdminEmailSubject"
                        Suffix=":"></dnn:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtAdminEmailSubject" CssClass="NormalTextBox" Width="390" Columns="30"
                        TextMode="SingleLine" MaxLength="2000" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="SubHead" valign="top">
                    <dnn:Label ID="lblAdminEmail" runat="server" ControlName="lblAdminEmail" Suffix=":"></dnn:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtAdminEmail" CssClass="NormalTextBox" Width="390" Columns="30"
                        TextMode="SingleLine" MaxLength="2000" runat="server" />
                    <asp:RegularExpressionValidator ID="regEmail" CssClass="NormalRed" runat="server"
                        ControlToValidate="txtAdminEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                          <%=Localization.GetString("ValidEmail.Text", LocalResourceFile)%>
                    </asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="SubHead" valign="middle">
                    <dnn:Label ID="lblAdminMailBody" runat="server" ControlName="lblAdminMailBody" Suffix=":"></dnn:Label>
                    <br />
                    <p>
                        <strong>[CUSTOMER:FIRSTNAME]: First Name<br />
                            [CUSTOMER:LASTNAME]: Last Name<br />
                            [CUSTOMER:EMAIL]: Email Address<br />
                            [CUSTOMER:MESSAGE]: Additional Message<br />
                            [CUSTOMER:PHONE]: Telephone number<br />
                            [CUSTOMER:CITY]: City<br />
                            [CUSTOMER:STATE]: State<br />
                            [CUSTOMER:ZIPCODE]: Zip Code<br />
                            [CUSTOMER:ADDRESS]: Address<br />
                            [CUSTOMER:POSITION]: Positions<br />
                            [CUSTOMER:SALONNAME]: Salon/spa Name<br />
                            [CUSTOMER:WISHLIST]: Wish List Items<br />
                            [DATETIME]: Date & Time<br />
                            [PORTAL]: WebSite Name
                        </strong>
                    </p>
                </td>
                <td valign="top">
                    <dnn:TextEditor ID="txtAdminMailBody" runat="server" DefaultMode="HTML" Height="400"
                        Width="600" />
                </td>
            </tr>
        </table>

    </fieldset>
</div>

<div id="divUserSection">
    <h2 id="SitePanel_Module" class="dnnFormSectionHead">
        <a href="" class="dnnSectionExpanded"><%=Localization.GetString("CustomerSettings.Text", LocalResourceFile)%></a>
    </h2>
    <fieldset>
        <table cellspacing="5" cellpadding="2" border="0">
            <tr>
                <td class="SubHead">
                    <dnn:Label ID="lblusersetting" runat="server" Suffix=":" ControlName="lblusersetting" />
                </td>
                <td valign="top">
                    <asp:CheckBox ID="Checkusersetting" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="SubHead" valign="top">
                    <dnn:Label ID="CustomerEmailSubject" runat="server" ControlName="CustomerEmailSubject"
                        Suffix=":"></dnn:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtCustomerEmailSubject" CssClass="NormalTextBox" Width="390" Columns="30"
                        TextMode="SingleLine" MaxLength="2000" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="SubHead" valign="middle">
                    <dnn:Label ID="lblCustomerEmailBody" runat="server" ControlName="lblCustomerEmailBody"
                        Suffix=":"></dnn:Label>
                    <br />
                    <p>
                        <strong>[CUSTOMER:FIRSTNAME]: First Name<br />
                            [CUSTOMER:LASTNAME]: Last Name<br />
                            [CUSTOMER:EMAIL]: Email Address<br />
                            [CUSTOMER:MESSAGE]: Additional Message<br />
                            [CUSTOMER:PHONE]: Telephone number<br />
                            [CUSTOMER:CITY]: City<br />
                            [CUSTOMER:STATE]: State<br />
                            [CUSTOMER:ZIPCODE]: Zip Code<br />
                            [CUSTOMER:ADDRESS]: Address<br />
                            [CUSTOMER:POSITION]: Positions<br />
                            [CUSTOMER:SALONNAME]: Salon/spa Name<br />
                            [CUSTOMER:WISHLIST]: Wish List Items<br />
                            [DATETIME]: Date & Time<br />
                            [PORTAL]: WebSite Name
                        </strong>
                    </p>
                </td>
                <td valign="top">
                    <dnn:TextEditor ID="txtCustomerEmailBody" runat="server" DefaultMode="HTML" Height="400"
                        Width="600" />
                </td>
            </tr>
        </table>

    </fieldset>
</div>



