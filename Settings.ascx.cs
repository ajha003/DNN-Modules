using System;
using System.Web.UI;

using DotNetNuke;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;
namespace Webtech4rindia.Modules.ContactUs
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The Settings class manages Module Settings
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <history>
    /// </history>
    /// -----------------------------------------------------------------------------
    partial class Settings : ModuleSettingsBase
    {

        #region Base Method Implementations

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// LoadSettings loads the settings from the Database and displays them
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// </history>
        /// -----------------------------------------------------------------------------
        public override void LoadSettings()
        {
            try
            {
                if (Page.IsPostBack == false)
                {


                    if (!string.IsNullOrEmpty(Convert.ToString(Settings["AdminEmailSubject"])))
                        txtAdminEmailSubject.Text = Convert.ToString(Settings["AdminEmailSubject"]);

                    if (!string.IsNullOrEmpty(Convert.ToString(Settings["AdminEmail"])))
                        txtAdminEmail.Text = Convert.ToString(Settings["AdminEmail"]);

                    if (!string.IsNullOrEmpty(Convert.ToString(Settings["AdminMailBody"])))
                        txtAdminMailBody.Text = Convert.ToString(Settings["AdminMailBody"]);

                    if (!string.IsNullOrEmpty(Convert.ToString(Settings["CustomerEmailSubject"])))
                        txtCustomerEmailSubject.Text = Convert.ToString(Settings["CustomerEmailSubject"]);

                    if (!string.IsNullOrEmpty(Convert.ToString(Settings["CustomerEmailBody"])))
                        txtCustomerEmailBody.Text = Convert.ToString(Settings["CustomerEmailBody"]);


                    if (!string.IsNullOrEmpty(Convert.ToString(Settings["Checkusersetting"])))
                    {
                        if (Convert.ToString(Settings["Checkusersetting"]) == "True")
                            Checkusersetting.Checked = true;
                        else
                            Checkusersetting.Checked = false;
                    }

                    //SMTP SEttings

                    if (!string.IsNullOrEmpty(Convert.ToString(Settings["Replyto"])))
                        txtReplyto.Text = Convert.ToString(Settings["Replyto"]);



                }
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// UpdateSettings saves the modified settings to the Database
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// </history>
        /// -----------------------------------------------------------------------------
        public override void UpdateSettings()
        {
            try
            {
                ModuleController objModules = new ModuleController();
                objModules.UpdateTabModuleSetting(TabModuleId, "AdminEmailSubject", txtAdminEmailSubject.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "AdminEmail", txtAdminEmail.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "AdminMailBody", txtAdminMailBody.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "CustomerEmailSubject", txtCustomerEmailSubject.Text);
                objModules.UpdateTabModuleSetting(TabModuleId, "CustomerEmailBody", txtCustomerEmailBody.Text);
                //SMTP Server Settings
                //objModules.UpdateTabModuleSetting(TabModuleId, "SMTPserver", txtSMTPServer.Text);
                //objModules.UpdateTabModuleSetting(TabModuleId, "SMTPusername", txtSMTPUsername.Text);
                //objModules.UpdateTabModuleSetting(TabModuleId, "SMTPpassword", txtSMTPPassword.Text);
                //if (CheckBoxSMTPSSlEnable.Checked)
                //    objModules.UpdateTabModuleSetting(TabModuleId, "SMTPSSlEnable", "True");
                //else
                //    objModules.UpdateTabModuleSetting(TabModuleId, "SMTPSSlEnable", "False");

                if (Checkusersetting.Checked)
                    objModules.UpdateTabModuleSetting(TabModuleId, "Checkusersetting", "True");
                else
                    objModules.UpdateTabModuleSetting(TabModuleId, "Checkusersetting", "False");

                objModules.UpdateTabModuleSetting(TabModuleId, "Replyto", txtReplyto.Text);

                //refresh cache
                //  SynchronizeModule();
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        #endregion

       
    }
}


