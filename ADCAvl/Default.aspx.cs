using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;

namespace ADCAvl
{
    public partial class _Default : Page
    {
        #region ENUMs
        enum ButtonMode
        {
            Edit = 1,
            Save,
            Cancel,
            None = 9
        }
        #endregion

        #region Properties
        string constr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        string LastComponent = "";
        static bool[] Included;
        static DataTable dt;
        static DataTable dt_pre;
        static Dictionary<string, int> DT_PH_Mapping = new Dictionary<string, int>();
        static int BtnEditCount = 0;
        #endregion

        #region Page Event & Bind Function
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindRepeater();
                DT_PH_Mapping.Add("phSta", 4);
                DT_PH_Mapping.Add("phAR", 21);
                DT_PH_Mapping.Add("phAO", 22);
            }
        }

        private void BindRepeater()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT [Unique_Id],[Fleet],[Aircraft],[Position],[Status]," +
                    "[Part_Number],[Serial_Number],[Life_Consumed_Hrs],[Life_Consumed_Cycles],[Installed_Since],[Date_Raised]," +
                    "[Data_Last_Upd],[Manual_Sanc_Comments],[Original_Risk],[Current_Risk],[Risk_Chg_Perc],[Life_Consumed]," +
                    "[Raw_Signal1],[Raw_Signal2],[Raw_Signal3],[Maint_Msg_FDE_TL_Ent],[Action_Required],[Action_Owner],[DST_Link]," +
                    "[Incl_in_Report],[Created_Date],[Updated_Date],[Component] FROM [reporting].[Report_Automation_Staging] Order By [Component]", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        dt = new DataTable();                         
                        sda.Fill(dt);
                        Included = new bool[dt.Rows.Count];
                        for (int i = 0; i < dt.Rows.Count; i++)
                            Included[i] = true;
                        RepeaterRecord.DataSource = dt;
                        RepeaterRecord.DataBind();
                    }
                }
            }
        }
        #endregion

        #region ASPX Helper Functions
        protected Boolean ShouldShow(String Component)
        {
            //System.Diagnostics.Debug.WriteLine(Component);
            if (LastComponent.CompareTo(Component) != 0)
            {
                LastComponent = Component;
                return true;
            }
            return false;
        }

        protected Boolean ChekNULL(String Value)
        {
            return (Value.Length != 0);
        }
        #endregion

        #region Control Events
        protected void Included_CheckedChanged(object sender, EventArgs e)
        {
            //System.Diagnostics.Debug.WriteLine("cbSta_CheckedChanged");
            //System.Diagnostics.Debug.WriteLine(sender);
            HtmlInputCheckBox cb = (HtmlInputCheckBox)sender;
            //System.Diagnostics.Debug.WriteLine(cb.TabIndex);
            //System.Diagnostics.Debug.WriteLine(string.Join(",", Included));
            string[] splits = cb.ClientID.Split('_');
            //System.Diagnostics.Debug.WriteLine(string.Join(",", splits));
            Included[Int32.Parse(splits[splits.Length - 1])] = cb.Checked;
            //System.Diagnostics.Debug.WriteLine(string.Join(",", Included));
        }

        protected void btnSend_Command(object sender, CommandEventArgs e)
        {
            foreach (DataColumn c in dt.Columns)
            {
                System.Diagnostics.Debug.Write(c.ColumnName + "\t");
            }
            System.Diagnostics.Debug.WriteLine("");
            foreach (DataRow row in dt.Rows)
            {
                foreach (var item in row.ItemArray)
                {
                    System.Diagnostics.Debug.Write(item + "\t");
                }
                System.Diagnostics.Debug.WriteLine("");
            }

            foreach (DataColumn c in dt.Columns)
            {
                System.Diagnostics.Debug.Write(c.ColumnName + "\t");
            }
            System.Diagnostics.Debug.WriteLine("");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow row = dt.Rows[i];
                if (!Included[i])
                {
                    row["Incl_in_Report"] = false;
                    continue;
                }
                row["Incl_in_Report"] = true;
                foreach (var item in row.ItemArray)
                {
                    System.Diagnostics.Debug.Write(item + "\t");
                }
                System.Diagnostics.Debug.WriteLine("");
            }

            SqlConnection con = new SqlConnection(constr);
            con.Open();
            string SQL_COMM = "INSERT INTO [reporting].[Report_Automation_Master]([Unique_Id],[Fleet],[Aircraft]," +
                "[Position],[Status],[Part_Number],[Serial_Number],[Life_Consumed_Hrs],[Life_Consumed_Cycles],[Installed_Since],[Date_Raised]," +
                "[Data_Last_Upd],[Manual_Sanc_Comments],[Original_Risk],[Current_Risk],[Risk_Chg_Perc],[Life_Consumed]," +
                "[Raw_Signal1],[Raw_Signal2],[Raw_Signal3],[Maint_Msg_FDE_TL_Ent],[Action_Required],[Action_Owner],[DST_Link]," +
                "[Incl_in_Report],[Created_Date],[Updated_Date],[Component]) VALUES(";
            foreach (DataRow row in dt.Rows)
            {
                string SQL_COMM_Row = SQL_COMM;
                foreach (var item in row.ItemArray)
                {
                    if (item.ToString().Length == 0)
                        SQL_COMM_Row += "NULL,";
                    else
                    {
                        double num;
                        if (double.TryParse(item.ToString(), out num))
                            SQL_COMM_Row += item + ",";
                        else
                            SQL_COMM_Row += "'" + item + "',";
                    }
                }
                SQL_COMM_Row = SQL_COMM_Row.Remove(SQL_COMM_Row.Length - 1);
                SQL_COMM_Row += ");";
                System.Diagnostics.Debug.WriteLine(SQL_COMM_Row);
                (new SqlCommand(SQL_COMM_Row, con)).ExecuteNonQuery();
            }            
            (new SqlCommand("UPDATE [reporting].[Report_Control_Ref] SET [Last_Report_Date] = '" + DateTime.Now.ToString("yyyy-MM-dd") + "';", con)).ExecuteNonQuery();
            con.Close();
        }

        protected void btnCheck_Command(object sender, CommandEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT [Unique_Id],[Fleet],[Aircraft],[Position],[Status]," +
                    "[Part_Number],[Serial_Number],[Life_Consumed_Hrs],[Life_Consumed_Cycles],[Installed_Since],[Date_Raised]," +
                    "[Data_Last_Upd],[Manual_Sanc_Comments],[Original_Risk],[Current_Risk],[Risk_Chg_Perc],[Life_Consumed]," +
                    "[Raw_Signal1],[Raw_Signal2],[Raw_Signal3],[Maint_Msg_FDE_TL_Ent],[Action_Required],[Action_Owner],[DST_Link]," +
                    "[Incl_in_Report],[Created_Date],[Updated_Date],[Component],[Submitted_Timestamp] FROM [reporting].[Report_Automation_Master]" +
                    " WHERE CAST([Submitted_Timestamp] AS DATE) = (SELECT [Last_Report_Date] FROM [reporting].[Report_Control_Ref]) Order By [Component];", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        dt_pre = new DataTable();
                        sda.Fill(dt_pre);
                        RepeaterPreviousRecord.DataSource = dt_pre;
                        RepeaterPreviousRecord.DataBind();
                    }
                }
            }
            lblModalTitle.Text = "Previous Report " + dt_pre.Rows[0]["Submitted_Timestamp"];
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "myModal", "$('#myModal').modal();", true);
            upModal.Update();
        }
        #endregion

        #region Repeater Events
        protected void RepeaterRecord_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //System.Diagnostics.Debug.WriteLine(e.Item.FindControl("cbSta"));
            //CheckBox cb = (CheckBox)e.Item.FindControl("cbSta");
            //if (cb != null)
            //    cb.InputAttributes["class"] = "tgl tgl-flat";
        }

        protected void RepeaterRecord_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(e.CommandName);
            ButtonModeToggled(e.Item, e.CommandName, DT_PH_Mapping.Keys.ToArray<string>());
        }
        #endregion

        #region Methods
        protected void ButtonModeToggled(RepeaterItem Item, string mode, string[] names = null)
        {
            Button btnMode = Item.FindControl("btnMode") as Button;
            Button btnCancel = Item.FindControl("btnCancel") as Button;

            ButtonMode ModeBtn = ButtonMode.None;

            if (mode.CompareTo("Edit") == 0) {
                BtnEditCount++;
                btnSend.Enabled = false;
                btnCancel.Visible = true;
                btnMode.Text = "Save";
                btnMode.CommandName = "Save";
                ModeBtn = ButtonMode.Edit;
            }
            if (mode.CompareTo("Save") == 0 || mode.CompareTo("Cancel") == 0)
            {
                if (--BtnEditCount == 0)
                {
                    btnSend.Enabled = true;
                }
                btnCancel.Visible = false;
                btnMode.Text = "Edit";
                btnMode.CommandName = "Edit";
                ModeBtn = mode.CompareTo("Save") == 0 ? ButtonMode.Save : mode.CompareTo("Cancel") == 0 ? ButtonMode.Cancel : ButtonMode.None;
            }
            if (ModeBtn != ButtonMode.None)
                foreach (string name in names)
                    AssignText(Item, name, ModeBtn);
        }

        private bool AssignText(RepeaterItem Item, string name, ButtonMode mode)
        {
            PlaceHolder ph = (PlaceHolder)Item.FindControl(name);
            if (ph == null)
                return NullReferenceException;

            if (mode == ButtonMode.Edit)
                return AssignTextControl((Label)ph.Controls[0], (TextBox)ph.Controls[1]);
            else if (mode == ButtonMode.Save)
            {
                UpdateDataTable(Item.ItemIndex, name, (TextBox)ph.Controls[1]);
                return AssignTextControl((TextBox)ph.Controls[1], (Label)ph.Controls[0]);
            }
            else if (mode == ButtonMode.Cancel)
                return AssignTextControl((TextBox)ph.Controls[1], (Label)ph.Controls[0], true);

            return WrongModeException;
        }

        private bool AssignTextControl(Label lb, TextBox tb)
        {
            if (lb == null || tb == null)
                return NullReferenceException;

            lb.Visible = false;
            tb.Visible = true;
            tb.Text = lb.Text;

            return true;
        }

        private bool AssignTextControl(TextBox tb, Label lb, bool isCancel = false)
        {
            if (lb == null || tb == null)
                return NullReferenceException;

            tb.Visible = false;
            lb.Visible = true;
            if (!isCancel)
                lb.Text = tb.Text;

            return true;
        }

        private void UpdateDataTable(int ItemIndex, string name, TextBox tb)
        {
            int index = -1;
            if (DT_PH_Mapping.TryGetValue(name, out index))
            {
                dt.Rows[ItemIndex][index] = tb.Text;
                dt.Rows[ItemIndex]["Updated_Date"] = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }
        #endregion

        #region Exception Overrides
        protected bool NullReferenceException
        {
            get { throw new NullReferenceException("Control Not Found"); }
        }

        protected bool WrongModeException
        {
            get { throw new Exception("Wrong Button Mode"); }
        }
        #endregion
    }
}