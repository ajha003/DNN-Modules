using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Web.UI;
using System.Web.UI.WebControls;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Localization;
using DotNetNuke.Services.Mail;
using DotNetNuke.Services.Exceptions;
using NEvoWeb.Modules.NB_Store;
namespace Webtech4rindia.Modules.ContactUs
{

    partial class ViewContactUs : PortalModuleBase
    {
        #region Public Properties
        public string GetTokensbyKey(string Keys, string defaultvalue)
        {
            if (Settings[Keys] != null)
                return Settings[Keys].ToString();
            return defaultvalue;
        }
        public string AdminEmailSubject
        {
            get
            {
                return GetTokensbyKey("AdminEmailSubject", "Email from your website! " + PortalAlias.HTTPAlias);


            }
        }
        public string AdminEmailID
        {
            get
            {

                //  return "webtech4rindia.test@gmail.com";
                return GetTokensbyKey("AdminEmail", "");
            }
        }
        public string AdminMailBody
        {
            get
            {
                return GetTokensbyKey("AdminMailBody", CreateAdminBody());
            }
        }
        public string CreateAdminBody()
        {
            string str = "<div style='font-family:verdana;font-size:12px'> Dear Admin,<br/>A New contact has been submitted on portal. Here is detail submitted by User.</br>";
            str = str + "<p>Name:&nbsp;{CUSTOMER:NAME}</p>";
            str = str + "<p>Phone:&nbsp;{CUSSTOMER:PHONE}</p>";
            str = str + "<p>Email:&nbsp;{CUSTOMER:EMAIL}</p>";
            str = str + "<p>Date & Time:&nbsp;" + System.DateTime.Now.ToShortDateString() + "</p>";
            str = str + "<p>Web Site:" + PortalAlias.HTTPAlias + "</p>";
            str = str + "<p>Thanks you , <br/>Web Notification</p></div>";


            return str;
        }

        public bool ISCustomerEmail
        {
            get
            {
                string stUEmail = GetTokensbyKey("Checkusersetting", CreateAdminBody());
                if (stUEmail != "")
                    return Convert.ToBoolean(stUEmail);
                return false;
            }
        }
        public string CustomerEmailSubject
        {
            get
            {
                return GetTokensbyKey("CustomerEmailSubject", "Website Information!");


            }
        }
        public string CustomerEmailBody
        {
            get
            {
                return GetTokensbyKey("CustomerEmailBody", CreateCustomerBody());


            }
        }


        public string CreateCustomerBody()
        {
            string str = "<div style='font-family:verdana;font-size:12px'> Dear {CUSTOMER:NAME},<br/>Your contact has been submitted on portal. Here is detail submitted by you.</br>";
            str = str + "<p>Name:&nbsp;{CUSTOMER:NAME}</p>";
            str = str + "<p>Phone:&nbsp;{CUSTOMER:PHONE}</p>";
            str = str + "<p>Email:&nbsp;{CUSTOMR:EMAIL}</p>";
            str = str + "<p>Date & Time:" + System.DateTime.Now.ToShortDateString() + "</p>";
            str = str + "<p>Web Site:" + PortalAlias.HTTPAlias + "</p>";
            str = str + "<p><br/></p><p>We are working on your query and will get in touch with you very quickly.</p><p></p>";

            return str;
        }

        #endregion

        public string ReplyTo
        {
            get
            {
                string strReplyto = GetTokensbyKey("Replyto", "");
                if (string.IsNullOrEmpty(strReplyto))
                    return AdminEmailID;
                return strReplyto;
            }
        }

        #region Event Handler
        private void SetUI()
        {



            btnSubmit.Text = Localization.GetString("btnSubmit.Text", LocalResourceFile);

            pnlInfo.Visible = true;
            pnlConfirmation.Visible = false;

        }
        public string GetResourceText(string key)
        {
            return Localization.GetString(key, LocalResourceFile);
        }
        public void BindWishList()
        {
            ArrayList plst = NEvoWeb.Modules.NB_Store.WishList.GetList(this.PortalId);

            if (plst.Count == 0)
            {
                btnSubmit.Enabled = false;
                pnlConfirmation.Visible = true;
                pnlInfo.Visible = false;
                lblMessage.Text = "Your wishlist is empty. Please add  items to your wishlist to submit your request.";
                //        DotNetNuke.UI.Skins.Skin.AddModuleMessage(this, "WishList Empty: Please add some product on your wishlist before submit your request!!", DotNetNuke.UI.Skins.Controls.ModuleMessage.ModuleMessageType.YellowWarning);
            }
            grdWishlist.DataSource = plst;

            grdWishlist.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetUI();
                BindWishList();
                BindStates(36);
                if (AdminEmailID == "")
                {


                    btnSubmit.Enabled = false;
                    if (UserInfo.IsInRole("Administrator") || UserInfo.IsSuperUser == true)
                    {
                        DotNetNuke.UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("NotConfigured_Admin.Text", LocalResourceFile), DotNetNuke.UI.Skins.Controls.ModuleMessage.ModuleMessageType.YellowWarning);

                    }
                    else
                        DotNetNuke.UI.Skins.Skin.AddModuleMessage(this, Localization.GetString("NotConfigured_User.Text", LocalResourceFile), DotNetNuke.UI.Skins.Controls.ModuleMessage.ModuleMessageType.YellowWarning);


                }

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            AddContact();


        }



        #endregion

        #region Public Method
        public string ParseTokens(ContactUsInfo oinfo, string strAdminBody)
        {
            strAdminBody = strAdminBody.Replace("[CUSTOMER:FIRSTNAME]", oinfo.FirstName);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:LASTNAME]", oinfo.LastName);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:EMAIL]", oinfo.EmailAddress);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:MESSAGE]", oinfo.AdditionalQuestion);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:PHONE]", oinfo.TelephoneNumber);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:CITY]", oinfo.City);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:STATE]", oinfo.State);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:ZIPCODE]", oinfo.ZipCode);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:ADDRESS]", oinfo.Address);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:POSITION]", oinfo.Positions);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:SALONNAME]", oinfo.SalonName);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:ISEMAILNOTIFICATION]", oinfo.IsEmailNotification.ToString());
            strAdminBody = strAdminBody.Replace("[CUSTOMER:ISDESIGNSERVICE]", oinfo.IsDesignService.ToString());
            strAdminBody = strAdminBody.Replace("[CUSTOMER:COUNTRY]", oinfo.Country);
            strAdminBody = strAdminBody.Replace("[CUSTOMER:WISHLIST]", GetWishListProductSelected());
            strAdminBody = strAdminBody.Replace("[DATETIME]", System.DateTime.Today.ToString("MMM d yyyy"));
            strAdminBody = strAdminBody.Replace("[PORTAL]", PortalAlias.HTTPAlias);
            strAdminBody = strAdminBody.Replace("[URL]", DotNetNuke.Common.Globals.NavigateURL(this.TabId));
            return strAdminBody;
        }
        private void SendEmailNotification(ContactUsInfo oinfo)
        {

            string strSMTPServer = Convert.ToString(DotNetNuke.Common.Globals.HostSettings["SMTPServer"]);
            string strSMTPUserName = Convert.ToString(DotNetNuke.Common.Globals.HostSettings["SMTPUsername"]);
            string strSMTPPassword = Convert.ToString(DotNetNuke.Common.Globals.HostSettings["SMTPPassword"]);

            string strSMTPAuthentication = Convert.ToString(DotNetNuke.Common.Globals.HostSettings["SMTPAuthentication"]);
            string strSMTPEnableSSL = Convert.ToString(DotNetNuke.Common.Globals.HostSettings["SMTPEnableSSL"]);
            bool IsSMTPEnableSSL = false;
            if (!string.IsNullOrEmpty(strSMTPEnableSSL))
            {
                if (strSMTPEnableSSL == "Y")
                    IsSMTPEnableSSL = true;
            }
            //HostController.Instance.Update("SMTPServer", txtSMTPServer.Text, false);
            //HostController.Instance.Update("SMTPAuthentication", optSMTPAuthentication.SelectedItem.Value, false);
            //HostController.Instance.Update("SMTPUsername", txtSMTPUsername.Text, false);
            //HostController.Instance.Update("SMTPPassword", txtSMTPPassword.Text, false);
            //HostController.Instance.Update("SMTPEnableSSL", chkSMTPEnableSSL.Checked ? "Y" : "N", false);

            if (strSMTPUserName == "")
                strSMTPUserName = AdminEmailID;



            string[] strvalue = new string[0];
            try
            {
                if (!string.IsNullOrEmpty(oinfo.EmailAddress))
                {
                    //Admin section

                    string strAdminSubject = ParseTokens(oinfo, AdminEmailSubject);
                    string strAdminBody = ParseTokens(oinfo, AdminMailBody);
                    DotNetNuke.Services.Mail.Mail.SendMail(AdminEmailID, AdminEmailID, "", "", txtEmail.Text, MailPriority.High, AdminEmailSubject, MailFormat.Html, System.Text.Encoding.UTF8, Server.HtmlDecode(strAdminBody), strvalue, strSMTPServer, strSMTPAuthentication, strSMTPUserName, strSMTPPassword, IsSMTPEnableSSL);

                    if (ISCustomerEmail)
                    {

                        string strUserSubject = ParseTokens(oinfo, CustomerEmailSubject);
                        string strUserBody = ParseTokens(oinfo, CustomerEmailBody);

                        DotNetNuke.Services.Mail.Mail.SendMail(AdminEmailID, txtEmail.Text, "", "", ReplyTo, MailPriority.High, strUserSubject, MailFormat.Html, System.Text.Encoding.UTF8, Server.HtmlDecode(strUserBody), strvalue, strSMTPServer, strSMTPAuthentication, strSMTPUserName, strSMTPPassword, IsSMTPEnableSSL);


                    }

                }

            }
            catch (Exception exc)
            {

                DotNetNuke.Services.Exceptions.Exceptions.ProcessModuleLoadException(this, exc);
            }



        }

        string[] attch = new string[1];
        public void AddContact()
        {
            try
            {
                if (txtName.Text == "")
                    return;
                ContactUsController _Controller = new ContactUsController();
                ContactUsInfo _Info = new ContactUsInfo();
                _Info.FirstName = txtName.Text;
                _Info.LastName = txtLastName.Text;
                _Info.EmailAddress = txtEmail.Text;
                _Info.TelephoneNumber = txtPhone.Text;
                _Info.AdditionalQuestion = DotNetNuke.Common.Globals.PreventSQLInjection(txtAdditionalQuestion.Text);
                _Info.PortalId = this.PortalId;
                _Info.ModuleId = this.ModuleId;
                _Info.CreatedDateTime = System.DateTime.Now;
                _Info.Address = txtAddress.Text;
                _Info.City = txtCity.Text;
                _Info.IsDesignService = chkTerms.Checked;
                _Info.ZipCode = txtZipCode.Text;
                _Info.Positions = txtpositionOther.Text;
                _Info.Country = ddCountry.SelectedValue;
                if (ddPosition.SelectedIndex != -2)
                    _Info.Positions = ddPosition.SelectedValue.ToString();
                _Info.SalonName = txtSalonName.Text;
                _Info.State = ddStates.SelectedValue;


                //    _Controller.AddContact(_Info);

                SendEmailNotification(_Info);
                txtName.Text = "";
                pnlInfo.Visible = false;
                pnlConfirmation.Visible = true;
                lblMessage.Text = Localization.GetString("Confirmation.Text", LocalResourceFile);

            }

            catch (Exception exc)
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }

        }

        #endregion
        protected void ddPosition_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddPosition.SelectedIndex == 3)
            {
                txtpositionOther.Visible = true;
                txtpositionOther.Focus();
            }
            else
                txtpositionOther.Visible = false;
        }

        protected void grdWishlist_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {

                NEvoWeb.Modules.NB_Store.WishList.RemoveProduct(this.PortalId, e.CommandArgument.ToString());
                BindWishList();

            }
        }
        protected void grdWishlist_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {

        }
        protected void grdWishlist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }
        protected void grdWishlist_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Telerik.Web.UI.RadNumericTextBox radnumeric = (Telerik.Web.UI.RadNumericTextBox)e.Row.FindControl("radQuantity");
                if (radnumeric != null)
                    if (radnumeric.Text == "")
                        radnumeric.Text = "1";

                ImageButton imgDelete = (ImageButton)e.Row.FindControl("imgDelete");
                if (imgDelete != null)
                {
                    DotNetNuke.UI.Utilities.ClientAPI.AddButtonConfirm(imgDelete, "Are you sure want to delete Product from wishlist?");
                }
            }
        }
        public string GetDescription(string unformated)
        {
            return Server.HtmlDecode(unformated);
        }
        public void BindStates(int Countryid)
        {
            ddStates.Items.Clear();
            if (Countryid == 36)
            {
                ddStates.Items.Add(new ListItem("Ontario", "Ontario"));
                ddStates.Items.Add(new ListItem("Quebec", "Quebec"));
                ddStates.Items.Add(new ListItem("Nova Scotia", "Nova Scotia"));
                ddStates.Items.Add(new ListItem("New Brunswick", "New Brunswick"));
                ddStates.Items.Add(new ListItem("Manitoba", "Manitoba"));
                ddStates.Items.Add(new ListItem("British Columbia", "British Columbia"));
                ddStates.Items.Add(new ListItem("Prince Edward Island", "Prince Edward Island"));
                ddStates.Items.Add(new ListItem("Saskatchewan", "Saskatchewan"));
                ddStates.Items.Add(new ListItem("Alberta", "Alberta"));
                ddStates.Items.Add(new ListItem("Newfoundland and Labrador", "Newfoundland and Labrador"));
                ddStates.Items[0].Selected = true;

            }
            else
            {

                DotNetNuke.Common.Lists.ListController lcontoller = new DotNetNuke.Common.Lists.ListController();
                ddStates.DataSource = lcontoller.GetListEntryInfoItems("Region", "Country.US", PortalId);
                ddStates.DataTextField = "Text";
                ddStates.DataValueField = "Text";
                ddStates.DataBind();
            }
        }
        protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindStates(Convert.ToInt32(ddCountry.SelectedValue));
        }


        public string GetWishListProductSelected()
        {
            System.Text.StringBuilder strBody = new System.Text.StringBuilder();
            Boolean IsProduct = false;
            strBody.Append("<table cellpadding='4' cellspacing='4' border='1' style='margin-left: 10px;'>");
            strBody.Append("<tr><td><b>Product Name</b></td><td><b>Product Description</b></td><td><b>Quantity</b></td></tr>");
            foreach (GridViewRow rWWishLists in grdWishlist.Rows)
            {
                Label lblProductName = (Label)rWWishLists.FindControl("lblProductName");
                Label lblProductDes = (Label)rWWishLists.FindControl("lblProductDes");

                Label lblProductId = (Label)rWWishLists.FindControl("lblProductId");
                Telerik.Web.UI.RadNumericTextBox Quantity = (Telerik.Web.UI.RadNumericTextBox)rWWishLists.FindControl("radQuantity");
                if (lblProductName != null)
                {
                    IsProduct = true;

                    strBody.Append(string.Format("<tr><td >{0}</td><td>{1}</td><td>{2}</td></tr>", lblProductName.Text, Server.HtmlDecode(lblProductDes.Text), Quantity.Text));
                    // NEvoWeb.Modules.NB_Store.WishList.RemoveProduct(this.PortalId, lblProductId.Text);
                }
            }
            strBody.Append("</table>");
            if (IsProduct)
                return strBody.ToString();
            return "";
        }
    }


}

