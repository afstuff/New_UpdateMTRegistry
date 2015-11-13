<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UpdateNIID.Web.Default" %>

<!DOCTYPE >

<html>
<head runat="server">
    <title>NIID</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/StyleSheet1.css" rel="stylesheet" />

    <script src="Scripts/jquery-1.9.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <%--<script src="Scripts/JavaScript1.js"></script>--%>


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
               <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h4>
                                NIID
                            </h4>
                        </div>
                        <div class="panel-body">
                            NIID description here
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-danger btn-block" ID="niibsBtn" Text="Click Here!" PostBackUrl="~/Default1.aspx" />
                            <%--<button class="btn btn-danger btn-block" id="niibsBtn">Click Here!</button>--%>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>

