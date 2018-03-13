<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ADCAvl._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card">
        <div class="card-block table-responsive">
            <asp:Repeater ID="RepeaterRecord" runat="server" OnItemCommand="RepeaterRecord_ItemCommand" OnItemDataBound="RepeaterRecord_ItemDataBound">                
                <HeaderTemplate>                    
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <%--<th scope="col">
                                    Unique_Id
                                </th>--%>
                                <th scope="col">
                                    Fleet
                                </th>
                                <th scope="col">
                                    Aircraft
                                </th>
                                <th scope="col">
                                    Position
                                </th>
                                <th scope="col">
                                    Status
                                </th>
                                <%--<th scope="col">
                                    Part Number
                                </th>
                                <th scope="col">
                                    Serial Number
                                </th>
                                <th scope="col">
                                    Life Consumed(Hrs)
                                </th>
                                <th scope="col">
                                    Life Consumed(Cycles)
                                </th>
                                <th scope="col">
                                    Installed Since
                                </th>
                                <th scope="col">
                                    Date Raised
                                </th>
                                <th scope="col">
                                    Date Last Updated
                                </th>
                                <th scope="col">
                                    Manual Sanc Comments
                                </th>
                                <th scope="col">
                                    Original Risk
                                </th>--%>
                                <th scope="col">
                                    Current Risk % <br />
                                    (Change)
                                </th>

                                <%--<th scope="col">
                                    Raw Signal 1
                                </th>
                                <th scope="col">
                                    Raw Signal 2
                                </th>
                                <th scope="col">
                                    Raw Signal 3
                                </th>
                                <th scope="col">
                                    Maintenance Message/FDE/Other TechLog Entries
                                </th>--%>
                                <th scope="col">
                                    Action Required
                                </th>
                                <th scope="col">
                                    Action Owner
                                </th>
                                <th scope="col">
                                    DST Link
                                </th>
                                <%--<th scope="col">
                                    Created Date
                                </th>
                                <th scope="col">
                                    Updated Date
                                </th> --%>
                                <th scope="col">
                                    Edit Row 
                                </th>
                                <th scope="col">
                                    Include in Report
                                </th>
                            </tr>
                        </thead>
                </HeaderTemplate>
                <ItemTemplate>
                        <asp:PlaceHolder ID="phHeader" runat="server" Visible='<%# ShouldShow(Eval("Component").ToString()) %>'>
                            <tr style="background-color: #dfdfdf;">
                                <th colspan="12">
                                    <asp:Label ID="lbUni" runat="server" Text='<%# Eval("Component") %>' />
                                </th>
                            </tr>
                        </asp:PlaceHolder>
                        <tr>
                            <%--<td>
                                <asp:Label ID="lbUni" runat="server" Text='<%# Eval("Unique_Id") %>' />
                            </td>--%>
                            <td>
                                <asp:Label ID="lbFle" runat="server" Text='<%# Eval("Fleet") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbAir" runat="server" Text='<%# Eval("Aircraft") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbPos" runat="server" Text='<%# Eval("Position") %>' />
                            </td>
                            <td>
                                <asp:PlaceHolder ID="phSta" runat="server">
                                    <asp:Label ID="lbSta" runat="server" Text='<%# Eval("Status") %>'/>
                                    <asp:TextBox ID="tbSta" runat="server" Visible="False"></asp:TextBox>
                                </asp:PlaceHolder>
                            </td>
                            <%--<td>
                                <asp:Label ID="lbPar" runat="server" Text='<%# Eval("Part_Number") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbSer" runat="server" Text='<%# Eval("Serial_Number") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbLCHr" runat="server" Text='<%# Eval("Life_Consumed_Hrs") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbLCCy" runat="server" Text='<%# Eval("Life_Consumed_Cycles") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbISi" runat="server" Text='<%# Eval("Installed_Since") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbDRa" runat="server" Text='<%# Eval("Date_Raised") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbDUp" runat="server" Text='<%# Eval("Data_Last_Upd") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbMSa" runat="server" Text='<%# Eval("Manual_Sanc_Comments") %>' />
                            </td>--%>
                            <%--<td>
                                <asp:Label ID="lbORi" runat="server" Text='<%# Eval("Original_Risk") %>' />
                            </td>--%>
                            <td>
                                <asp:Label ID="lbCR" runat="server" Text='<%# Eval("Current_Risk") %>' />
                                <asp:Label ID="lbRCP" runat="server" Visible='<%# ChekNULL(Eval("Risk_Chg_Perc").ToString()) %>' Text='<%# " (" +  Eval("Risk_Chg_Perc") + ")" %>' />
                            </td>
                            <%--<td>
                                <asp:Label ID="lbSi1" runat="server" Text='<%# Eval("Raw_Signal1") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbSi2" runat="server" Text='<%# Eval("Raw_Signal2") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbSi3" runat="server" Text='<%# Eval("Raw_Signal3") %>' />
                            </td>
                            <td>
                                <asp:Label ID="lbMsg" runat="server" Text='<%# Eval("Maint_Msg_FDE_TL_Ent") %>' />
                            </td> --%>
                            <td>
                                <asp:PlaceHolder ID="phAR" runat="server">
                                    <asp:Label ID="lbAR" runat="server" Text='<%# Eval("Action_Required") %>'/>
                                    <asp:TextBox ID="tbAR" runat="server" Visible="False"></asp:TextBox>
                                </asp:PlaceHolder>
                            </td>
                            <td>
                                <asp:PlaceHolder ID="phAO" runat="server">
                                    <asp:Label ID="lbAO" runat="server" Text='<%# Eval("Action_Owner") %>'/>
                                    <asp:TextBox ID="tbAOw" runat="server" Visible="False"></asp:TextBox>
                                </asp:PlaceHolder>
                            </td>
                            <td>
                                <asp:Label ID="lbDST" runat="server" />
                                <a href='<%# Eval("DST_Link") %>'>details</a>
                            </td>
                            <td>
                                <asp:Button ID="btnMode" runat="server" Text="Edit" CommandName="Edit" UseSubmitBehavior="False" CssClass="btn btn-primary"/>
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" UseSubmitBehavior="False" Visible="False" CssClass="btn btn-danger"/>
                            </td>
                            <td>
                                <div class="onoffswitch">
                                    <input type="checkbox" runat="server" onchange="__doPostBack('myonoffswitch','')" onserverchange="Included_CheckedChanged" name="onoffswitch" class="onoffswitch-checkbox" id="myonoffswitch" checked>
                                    <label class="onoffswitch-label" for="MainContent_RepeaterRecord_myonoffswitch_<%# Container.ItemIndex %>">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
        <div>
            <asp:Button ID="btnSend" runat="server" Text="Send Email" OnCommand="btnSend_Command" />
        </div>
        <div>
            <asp:Button ID="btnCheck" runat="server" Text="Check Previous Report" OnCommand="btnCheck_Command"  />
        </div>
    </div>
    <!-- Bootstrap Model -->
    <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content modal-lg">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title"><asp:Label ID="lblModalTitle" runat="server" Text=""></asp:Label></h4>
                        </div>
                        <div class="modal-body">
                            <div class="card">
                                <div class="card-block table-responsive">
                                    <asp:Repeater ID="RepeaterPreviousRecord" runat="server">                
                                        <HeaderTemplate>                    
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <%--<th scope="col">
                                                            Unique_Id
                                                        </th>--%>
                                                        <th scope="col">
                                                            Fleet
                                                        </th>
                                                        <th scope="col">
                                                            Aircraft
                                                        </th>
                                                        <th scope="col">
                                                            Position
                                                        </th>
                                                        <th scope="col">
                                                            Status
                                                        </th>
                                                        <%--<th scope="col">
                                                            Part Number
                                                        </th>
                                                        <th scope="col">
                                                            Serial Number
                                                        </th>
                                                        <th scope="col">
                                                            Life Consumed(Hrs)
                                                        </th>
                                                        <th scope="col">
                                                            Life Consumed(Cycles)
                                                        </th>
                                                        <th scope="col">
                                                            Installed Since
                                                        </th>
                                                        <th scope="col">
                                                            Date Raised
                                                        </th>
                                                        <th scope="col">
                                                            Date Last Updated
                                                        </th>
                                                        <th scope="col">
                                                            Manual Sanc Comments
                                                        </th>
                                                        <th scope="col">
                                                            Original Risk
                                                        </th>--%>
                                                        <th scope="col">
                                                            Current Risk % <br />
                                                            (Change)
                                                        </th>

                                                        <%--<th scope="col">
                                                            Raw Signal 1
                                                        </th>
                                                        <th scope="col">
                                                            Raw Signal 2
                                                        </th>
                                                        <th scope="col">
                                                            Raw Signal 3
                                                        </th>
                                                        <th scope="col">
                                                            Maintenance Message/FDE/Other TechLog Entries
                                                        </th>--%>
                                                        <th scope="col">
                                                            Action Required
                                                        </th>
                                                        <th scope="col">
                                                            Action Owner
                                                        </th>
                                                        <th scope="col">
                                                            DST Link
                                                        </th>
                                                        <%--<th scope="col">
                                                            Created Date
                                                        </th>
                                                        <th scope="col">
                                                            Updated Date
                                                        </th> --%>
                                                        <th scope="col">
                                                            Include in Report
                                                        </th>
                                                    </tr>
                                                </thead>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                                <asp:PlaceHolder ID="phHeaderM" runat="server" Visible='<%# ShouldShow(Eval("Component").ToString()) %>'>
                                                    <tr style="background-color: #dfdfdf;">
                                                        <th colspan="12">
                                                            <asp:Label ID="lbUniM" runat="server" Text='<%# Eval("Component") %>' />
                                                        </th>
                                                    </tr>
                                                </asp:PlaceHolder>
                                                <tr>
                                                    <%--<td>
                                                        <asp:Label ID="lbUni" runat="server" Text='<%# Eval("Unique_Id") %>' />
                                                    </td>--%>
                                                    <td>
                                                        <asp:Label ID="lbFleM" runat="server" Text='<%# Eval("Fleet") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbAirM" runat="server" Text='<%# Eval("Aircraft") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbPosM" runat="server" Text='<%# Eval("Position") %>' />
                                                    </td>
                                                    <td>
                                                            <asp:Label ID="lbStaM" runat="server" Text='<%# Eval("Status") %>'/>
                                                    </td>
                                                    <%--<td>
                                                        <asp:Label ID="lbPar" runat="server" Text='<%# Eval("Part_Number") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbSer" runat="server" Text='<%# Eval("Serial_Number") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbLCHr" runat="server" Text='<%# Eval("Life_Consumed_Hrs") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbLCCy" runat="server" Text='<%# Eval("Life_Consumed_Cycles") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbISi" runat="server" Text='<%# Eval("Installed_Since") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbDRa" runat="server" Text='<%# Eval("Date_Raised") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbDUp" runat="server" Text='<%# Eval("Data_Last_Upd") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbMSa" runat="server" Text='<%# Eval("Manual_Sanc_Comments") %>' />
                                                    </td>--%>
                                                    <%--<td>
                                                        <asp:Label ID="lbORi" runat="server" Text='<%# Eval("Original_Risk") %>' />
                                                    </td>--%>
                                                    <td>
                                                        <asp:Label ID="lbCR" runat="server" Text='<%# Eval("Current_Risk") %>' />
                                                        <asp:Label ID="lbRCP" runat="server" Visible='<%# ChekNULL(Eval("Risk_Chg_Perc").ToString()) %>' Text='<%# " (" +  Eval("Risk_Chg_Perc") + ")" %>' />
                                                    </td>
                                                    <%--<td>
                                                        <asp:Label ID="lbSi1" runat="server" Text='<%# Eval("Raw_Signal1") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbSi2" runat="server" Text='<%# Eval("Raw_Signal2") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbSi3" runat="server" Text='<%# Eval("Raw_Signal3") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbMsg" runat="server" Text='<%# Eval("Maint_Msg_FDE_TL_Ent") %>' />
                                                    </td> --%>
                                                    <td>
                                                            <asp:Label ID="lbARM" runat="server" Text='<%# Eval("Action_Required") %>'/>
                                                    </td>
                                                    <td>
                                                            <asp:Label ID="lbAOM" runat="server" Text='<%# Eval("Action_Owner") %>'/>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbDSTM" runat="server" />
                                                        <a href='<%# Eval("DST_Link") %>'>details</a>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Incl_in_Report") %>'/>
                                                    </td>
                                                </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-info" data-dismiss="modal" aria-hidden="true">Close</button>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
        <%: Styles.Render("~/Content/css") %>
    </asp:PlaceHolder>
</asp:Content>
