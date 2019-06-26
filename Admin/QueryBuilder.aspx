<%@ Page Title="Query Builder" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/AdminBattelle.Master" CodeBehind="QueryBuilder.aspx.vb" Inherits="Battelle.QueryBuilder" %>

<%@ Register Assembly="Korzh.EasyQuery.WebControls.NET45" Namespace="Korzh.EasyQuery.WebControls" TagPrefix="keqwc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%=Page.Title%></h1>



            <div class="container">
                <div class="row">
                    <div class="col-md-4">


                        <h4>Tables and Columns</h4>

                        <keqwc:EntitiesPanel ID="EntitiesPanel1" runat="server" Width="100%" ToolBarOnTop="False" Height="420px"></keqwc:EntitiesPanel>

                    </div>


                    <div class="col-md-8">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-8">
                                    <h4>Result columns</h4>
                                    <keqwc:QueryColumnsPanel ID="QueryColumnsPanel1" runat="server" Width="100%" TitleColumnWidth="100%" Height="200px"></keqwc:QueryColumnsPanel>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-8">
                                    <h4>Query conditions</h4>
                                    <keqwc:QueryPanel ID="QueryPanel1" runat="server" Width="100%" Height="200px"></keqwc:QueryPanel>
                                </div>
                            </div>

                        </div>
                    </div>



                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:LinkButton ID="LinkButtonExecute" runat="server" CssClass="btn btn-success"><span class="glyphicon glyphicon-refresh"></span> Execute</asp:LinkButton>
                        <asp:LinkButton ID="LinkButtonClear" runat="server" CssClass="btn btn-primary"><span class="glyphicon glyphicon-remove"></span> Clear</asp:LinkButton>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:Panel ID="PanelResult" runat="server" Visible="False">
                        <h3>Result</h3>
                      
                <asp:LinkButton ID="LinkButtonExport" runat="server"><span class="glyphicon glyphicon-save"></span> Export to Excel</asp:LinkButton>
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1"></asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"></asp:SqlDataSource>
                    </asp:Panel></div>
                </div>
            </div>




</asp:Content>
