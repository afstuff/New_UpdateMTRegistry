<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default1.aspx.cs" Inherits="UpdateNIID.Web.Default1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>NIID</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/StyleSheet1.css" rel="stylesheet" />

    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>

</head>
<body style="background-color: #f5f5f4;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <div class="container">
            <div class="row bg-danger" style="-ms-border-radius: 5px !important; border-radius: 0 0 5px 5px !important; top: 0 !important;">
                <div class="col-lg-12" style="padding: 15px;">
                    <img src="Images/cp1.fw.png" align="left" style="height: 90px;" />
                    <h1>ABS SERVICES COMMAND AND CONTROL CENTER</h1>
                </div>
            </div>
        </div>
        <div class="container" style="margin-top: 40px">
            <asp:Panel runat="server" ID="panel1" Visible="False">
                 <div class="row">
                <div class="col-md-12">
                    <span class="btn btn-sm btn-default">NIID Status:
                                <asp:Label ID="onlineLbl" runat="server" Text=""></asp:Label>
                    </span>
                    <asp:Image ID="statusImg" runat="server" />

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

                </div>
            </div>
            </asp:Panel>
            
            <br />
            <div class="row">
                <div class="col-md-10">
                    <div class="form-inline">
                        <asp:Label runat="server">
                        Filter Options:
                        </asp:Label>
                        <asp:DropDownList CssClass="form-control" ID="filterDdw" runat="server" Style="width: 150px !important;">
                            <asp:ListItem Value="0">All</asp:ListItem>
                            <asp:ListItem Value="1">Insured Name</asp:ListItem>
                            <asp:ListItem Value="2">Policy Number</asp:ListItem>
                            <asp:ListItem Value="3">Vehicle Number</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtSvalue" placeholder="Search Value" class="form-control small" runat="server" Width="150px"></asp:TextBox>

                        <asp:Label runat="server">Date(dd/mm/yyyy): </asp:Label>
                        <asp:TextBox ID="txtStartDate" placeholder="Start Date" class="form-control small" runat="server" Width="100px"></asp:TextBox>
                        <asp:TextBox ID="txtEndDate" placeholder="End Date" class="form-control small" runat="server" Width="100px"></asp:TextBox>
                        <asp:Button ID="searchBtn" runat="server" Text="Search" class="btn btn-sm btn-danger" OnClick="DoSearch" />

                    </div>
                </div>
                <div class="col-md-2">
                     <span class="btn btn-sm btn-primary pull-right">Today: 
                    <%
                        var today = DateTime.Today.ToString("dd/M/yyyy");
                        { Response.Write("<b>" + today + "</b>"); } 
                    %>
                    </span>
                </div>
            </div>
        </div>

        <div class="container" style="margin-top: 10px">
            <div class="row">
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" CaptionAlign="Left" CellPadding="10" ForeColor="#333333" GridLines="None" Width="100%" AutoGenerateColumns="False"
                            EmptyDataText="No data available." Font-Names="Century Gothic" Font-Size="11pt" HorizontalAlign="Left" OnPageIndexChanging="GridView1_PageIndexChanging" AllowPaging="True" OnRowDataBound="GridView1_RowDataBound" DataKeyNames="NIID_NO">
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Names="Century Gothic" Font-Size="10pt" />
                            <PagerSettings PageButtonCount="5" />
                            <PagerStyle CssClass="gridview" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" Font-Size="11pt" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSel" Visible="False" runat="server" Style="margin: 10px!important;"></asp:CheckBox>
                                        <%-- </ItemTemplate>
                                    <ItemTemplate>--%>
                                        <asp:HiddenField ID="Id_No" Value='<%# Eval("NIID_NO") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Policy #" DataField="NIID_PolicyNo" />
                                <asp:BoundField HeaderText="Insured Name" DataField="NIID_InsuredName" />
                                <asp:BoundField HeaderText="Vehicle Reg." DataField="NIID_RegistrationNo" />
                                <asp:BoundField HeaderText="Start Date" DataField="NIID_EffectiveCoverDate" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="End Date" DataField="NIID_ExpirationDate" DataFormatString="{0:dd/MM/yyyy}" />
                                <asp:BoundField HeaderText="Cover Type" DataField="NIID_TypeOfCover" />
                                <asp:BoundField HeaderText="Update Status" DataField="NIID_ReturnMessage" />
                                <asp:BoundField HeaderText="St" DataField="NIID_Status" />
                                <asp:BoundField HeaderText="Upload Date" DataField="NIID_UploadDate" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-CssClass="marginItem" HeaderStyle-CssClass="marginItem" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" HorizontalAlign="Left" VerticalAlign="Middle" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#9ACD32" ForeColor="White" Height="25px" HorizontalAlign="Left" VerticalAlign="Middle"></HeaderStyle>
                            <RowStyle Font-Names="century gothic" Font-Size="10pt" Height="25px" HorizontalAlign="Left" VerticalAlign="Middle"></RowStyle>
                            <SelectedRowStyle BackColor="LightCyan" ForeColor="DarkBlue" Font-Bold="true" />
                        </asp:GridView>
                        <asp:Timer ID="Timer1" runat="server" Interval="60000" OnTick="Timer1_Tick" Enabled="False" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1">
                    <ProgressTemplate>
                        <div class="PleaseWait">
                            Please Wait...
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
            <br />
            <div class="row">
                <asp:Button runat="server" Visible="False" ID="uploadBtn" Text="Update" CssClass="btn btn-danger btn-sm pull-right" Style="margin-right: 0 !important;" OnClick="DoUpdate" />
            </div>
        </div>


    </form>
</body>
</html>
