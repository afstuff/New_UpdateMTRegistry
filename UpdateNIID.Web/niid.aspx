<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="niid.aspx.cs" Inherits="UpdateNIID.Web.niid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NIID</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/StyleSheet1.css" rel="stylesheet" />

    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script src="Scripts/JavaScript1.js"></script>

    <script type="text/javascript">
       

    </script>
    <style>
        .t_light {
            height: 90px;
            width: auto;
        }

        .PleaseWait {
            height: 32px;
            width: 500px;
            background-image: url(Images/PleaseWait.gif);
            background-repeat: no-repeat;
            padding-left: 40px;
            line-height: 32px;
        }
    </style>
</head>
<body style="background-color: #f5f5f4;">
    <form id="form1" runat="server">
        <div class="container">
            <div class="row bg-danger" style="-ms-border-radius: 5px !important; border-radius: 0 0 5px 5px !important; top: 0 !important;">
                <div class="col-lg-12" style="padding: 15px;">
                    <img src="Images/cp1.fw.png" align="left" style="height: 90px;" />
                    <h1>ABS SERVICES COMMAND AND CONTROL CENTER</h1>
                </div>
            </div>
        </div>

        <div class="container" style="margin-top: 40px">
            <div class="row">
                <div class="col-md-12">
                    <span class="btn btn-sm btn-default">NIID Status:
                                <asp:Label ID="onlineLbl" runat="server" Text=""></asp:Label></span>
                    <asp:Image ID="statusImg" runat="server" CssClass="t_light" />
                    <%--<img src="Images/greenlight.fw.png" class="t_light" />--%>
                    <span class="btn btn-sm btn-primary pull-right">Today: 
                    <%
                        var today = DateTime.Today.ToString("dd/M/yyyy");
                        { Response.Write("<b>" + today + "</b>"); } 
                    %>
                    </span>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-md-12">
                    <div class="btn-group">
                        <button class="btn btn-sm btn-default">
                            No of Records Posted: <span class="badge">
                                <asp:Label ID="lblPosted" Text="" runat="server" />
                            </span>
                        </button>
                        <button class="btn btn-sm btn-default">
                            No of Records Uploaded: <span class="badge">
                                <asp:Label ID="lblUploaded" Text="" runat="server" />
                            </span>
                        </button>
                    </div>
                    <div class="pull-right">
                        <div class="form-inline">
                            <asp:Label runat="server" CssClass="label" Style="color: black !important; font-size: 11pt;">Filter By Date (dd/mm/yyyy): </asp:Label>
                            <asp:TextBox ID="txtStartDate" class="form-control small" runat="server" Width="150px"></asp:TextBox>
                            <asp:TextBox ID="txtEndDate" class="form-control small" runat="server" Width="150px"></asp:TextBox>
                            <asp:Button ID="searchBtn" runat="server" Text="Search" class="btn btn-sm btn-danger" OnClick="DoSearch" />
                            <%--<button class="btn btn-sm btn-danger"><i class="glyphicon glyphicon-search"></i>Go</button> OnClick="GetVehicleDateails(txtStartDate, txtEndDate)" --%>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <br />
        <div class="container">
            <div class="col-md-12" style="padding: 0 !important;">
                <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <ContentTemplate>--%>
             <%--<asp:GridView ID="GridView2" runat="server" CaptionAlign="Left" CellPadding="10" EnableModelValidation="True" ForeColor="#333333" GridLines="None" Width="100%" AutoGenerateColumns="False" AllowPaging="True" PagerSettings-Position="TopAndBottom" PagerSettings-Mode="NextPreviousFirstLast"
                            PagerSettings-FirstPageText="First" PagerSettings-NextPageText="Next"
                            PagerSettings-PreviousPageText="Previous" PagerSettings-LastPageText="Last"
                            EmptyDataText="No data available." Font-Names="Century Gothic" Font-Size="11pt" HorizontalAlign="Left" OnRowDataBound="GridView2_RowDataBound" OnPageIndexChanging="GridView2_PageIndexChanging">
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Names="Century Gothic" Font-Size="10pt" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" Font-Size="11pt" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSel" runat="server" Style="margin: 10px!important;"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Policy #" DataField="NIID_PolicyNo" />
                                <asp:BoundField HeaderText="Insured Name" DataField="NIID_InsuredName" />
                                <asp:BoundField HeaderText="Vehicle Reg." DataField="NIID_RegistrationNo" />
                                <asp:BoundField HeaderText="Start Date" DataField="NIID_EffectiveCoverDate" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="End Date" DataField="NIID_ExpirationDate" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="Cover Type" DataField="NIID_TypeOfCover" />
                                <asp:BoundField HeaderText="Update Status" DataField="NIID_ReturnMessage" />
                                <asp:BoundField HeaderText="Status Remark" DataField="NIID_Status" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" HorizontalAlign="Left" VerticalAlign="Middle" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#9ACD32" ForeColor="White" Height="25px" HorizontalAlign="Left" VerticalAlign="Middle"></HeaderStyle>

                            <PagerSettings FirstPageText="First" LastPageText="Last" NextPageText="Next" PreviousPageText="Previous"></PagerSettings>

                            <PagerStyle></PagerStyle>
                            <RowStyle Font-Names="century gothic" Font-Size="10pt" Height="25px" HorizontalAlign="Left" VerticalAlign="Middle"></RowStyle>
                            <SelectedRowStyle BackColor="LightCyan" ForeColor="DarkBlue" Font-Bold="true" />
                        </asp:GridView>--%>
                 <asp:GridView ID="GridView2" runat="server" CaptionAlign="Left" CellPadding="10" ForeColor="#333333" GridLines="None" Width="100%" AutoGenerateColumns="False" 
                            EmptyDataText="No data available." Font-Names="Century Gothic" Font-Size="11pt" HorizontalAlign="Left" OnPageIndexChanging="GridView2_PageIndexChanging" AllowPaging="True">
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Names="Century Gothic" Font-Size="10pt" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" Font-Size="11pt" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSel" runat="server" Style="margin: 10px!important;"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Policy #" DataField="NIID_PolicyNo" />
                                <asp:BoundField HeaderText="Insured Name" DataField="NIID_InsuredName" />
                                <asp:BoundField HeaderText="Vehicle Reg." DataField="NIID_RegistrationNo" />
                                <asp:BoundField HeaderText="Start Date" DataField="NIID_EffectiveCoverDate" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="End Date" DataField="NIID_ExpirationDate" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="Cover Type" DataField="NIID_TypeOfCover" />
                                <asp:BoundField HeaderText="Update Status" DataField="NIID_ReturnMessage" />
                                <asp:BoundField HeaderText="Status Remark" DataField="NIID_Status" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" HorizontalAlign="Left" VerticalAlign="Middle" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#9ACD32" ForeColor="White" Height="25px" HorizontalAlign="Left" VerticalAlign="Middle"></HeaderStyle>

                            <PagerSettings FirstPageText="First" LastPageText="" NextPageText="" PreviousPageText=""></PagerSettings>

                            <PagerStyle></PagerStyle>
                            <RowStyle Font-Names="century gothic" Font-Size="10pt" Height="25px" HorizontalAlign="Left" VerticalAlign="Middle"></RowStyle>
                            <SelectedRowStyle BackColor="LightCyan" ForeColor="DarkBlue" Font-Bold="true" />
                        </asp:GridView>

                        <br />
                      <%--  <asp:ObjectDataSource ID="ods" runat="server" SelectMethod="MotorDetails"
                            TypeName="UpdateNIID.Data.MotorDetailsRepository"></asp:ObjectDataSource>--%>
                        
       <%-- <asp:Timer ID="Timer1" runat="server" Interval="100000" OnTick="Timer1_Tick" Enabled="True" />


                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1">
                    <ProgressTemplate>
                        <div class="PleaseWait">
                            Please Wait...
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>--%>

            </div>

        </div>
        <%--10 second--%>

        <br />
        <div class="container">
            <div class="row">
                <asp:Button runat="server" ID="uploadBtn" Text="Update" CssClass="btn btn-danger btn-sm pull-right" Style="margin-right: 15px !important;" OnClick="DoUpdate" />
            </div>
        </div>

    </form>
</body>


</html>

