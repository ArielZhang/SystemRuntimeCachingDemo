<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SystemRuntimeCachingDemo.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 558px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <table class="auto-style1">
                    <tr>
                        <td class="auto-style2">
                            <asp:Label ID="Label1" runat="server" Text="Input something to caching: "></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                        <td rowspan="8">
                           
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:Label ID="Label2" runat="server" Text="Key: "></asp:Label>
                            <asp:TextBox ID="CacheKey" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Value: "></asp:Label>
                            <asp:TextBox ID="CacheData" runat="server" Width="243px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:Label ID="Label5" runat="server" Text="Expiration"></asp:Label>
                            <asp:DropDownList ID="ExpirationType" runat="server">
                                <asp:ListItem>AbsoluteExpiration</asp:ListItem>
                                <asp:ListItem>SlidingExpiration</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="ExpirationTime" runat="server"></asp:TextBox>
                            <asp:Label ID="Label6" runat="server" Text="Seconds"></asp:Label>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:Label ID="Label4" runat="server" Text="Policy Call Back: "></asp:Label>
                            <asp:DropDownList ID="PolicyCallback" runat="server">
                                <asp:ListItem>CacheEntryRemovedCallback</asp:ListItem>
                                <asp:ListItem>CacheEntryUpdateCallback</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:Label ID="Label8" runat="server" Text="Priority: "></asp:Label>
                            <asp:DropDownList ID="PriorityList" runat="server">
                                <asp:ListItem>Default</asp:ListItem>
                                <asp:ListItem>NotRemovable</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="Label10" runat="server" Font-Size="Small" Text="NotRemovable The cache items with this priority level will not be automatically deleted from the cache as the server frees system memory. However, items with this priority level are removed along with other items according to the item's absolute or sliding expiration time."></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:Label ID="Label9" runat="server" Text="CacheEntryChangeMonitor: "></asp:Label>
                            <asp:TextBox ID="Monitor" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            Input Cache Items Key, split by comma. [1,2,3,4,5]</td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Trim" />
                            <asp:TextBox ID="TrimPer" runat="server"></asp:TextBox>&nbsp&nbsp&nbsp
                            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Insert 10K Cache Items" />
                        </td>
                        <td>
                            <asp:Label ID="Label11" runat="server" Font-Size="Small" Text="The Trim property first removes entries that have exceeded either an absolute or sliding expiration. Any callbacks that are registered for items that are removed will be passed a removed reason of Expired.

If removing expired entries is insufficient to reach the specified trim percentage, additional entries will be removed from the cache based on a least-recently used (LRU) algorithm until the requested trim percentage is reached. Any callbacks that are registered for items that are removed this way will be passed a remove reason of Evicted.
"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:Button ID="CacheBtn" runat="server" OnClick="Cache_Click" Text="Cache Item" Width="131px" />&nbsp&nbsp&nbsp
                            <asp:Label ID="Label7" runat="server" Text="Cache Item Key:"></asp:Label>
                            <asp:TextBox ID="CacheItemKey" runat="server"></asp:TextBox>
                            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="View" />
                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" style="margin-left: 0px" Text="Clear" />
                        </td>
                        <td>
                            <asp:Button ID="ViewAllCacheBtn" runat="server" OnClick="ViewAllCacheBtn_Click" Text="View All Cache Items" />
                            <asp:Button ID="ClearBtn" runat="server" OnClick="Clear_Click" Text="Clear All Cache Items" />
                        </td>
                    </tr>
                </table>
        <br /><br />
         <div style="float: left;">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Label ID="Messages" runat="server" Font-Size="Medium" Height="400px" Width="1500px"></asp:Label>
                            <asp:Timer ID="Timer1" runat="server" Interval="10000" OnTick="Timer1_Tick">
                            </asp:Timer>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="Button1" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="Button2" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="Button3" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="Button4" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="CacheBtn" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="ClearBtn" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="ViewAllCacheBtn" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                                </div>

    </div>
    </form>
</body>
</html>
