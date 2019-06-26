<%@ Page Title="Short Course Registration" Language="vb" AutoEventWireup="false" MasterPageFile="~/Registration/Registration.Master" CodeBehind="ShortCourse.aspx.vb" Inherits="Battelle.ShortCourse" %>

<%@ Register Src="../ParticipationIDLogin.ascx" TagName="ParticipationIDLogin" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <h1><%=Page.Title%></h1>
            
     <asp:Panel ID="PanelClosed" runat="server" Visible="false">
         <asp:Label ID="lblClosed" runat="server" Text="Short Course Registration is currently closed."></asp:Label>
      </asp:Panel>
     <asp:Panel ID="PanelParticipationControl" runat="server" Visible="True">
        <uc1:ParticipationIDLogin ID="ParticipationIDLogin" runat="server" />
    </asp:Panel>

    <asp:Panel ID="PanelForm" runat="server" Visible="False">

        <asp:PlaceHolder ID="PlaceHolderPromoCodeValidation" runat="server">

            <asp:SqlDataSource ID="SqlDataSourcePromoValidate" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCoursePromoCodeCheck" SelectCommandType="StoredProcedure">
            <SelectParameters>
               <asp:Parameter Name="PersonID" Type="Int32" />
               <asp:Parameter Name="ConferenceID" Type="Int32" />
               <asp:Parameter Name="CourseID" Type="Int32" /> 
               <asp:ControlParameter ControlID="txtPromoCodeID" Name="ShortCoursePromoCode_IN" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:Label ID="lblPromoDiv" runat="server" Text=""></asp:Label>
        <asp:HiddenField ID="hdnPromoCode" runat="server" />
        <asp:HiddenField ID="hdnPromoValid" runat="server" />
        <div class="row">
            <div class="col-md-12">
                 <asp:Label ID="lblPromoCodeID" runat="server" Text="*Promo Code:" AssociatedControlID="txtPromoCodeID"></asp:Label> 
                 <small>(Note: If you have a promo code, validate it here)</small>
            </div>
            <div class="col-md-4">
                 <div class="input-group">
                     <asp:TextBox ID="txtPromoCodeID" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                         <span class="input-group-btn">                    
                              <asp:Button ID="btnPromoCodeValidate" runat="server" Text="Validate" CssClass="btn btn-default" OnClick="btnPromoCodeValidate_Click" CausesValidation="False" CommandName=""   />                              
                         </span>                                                        
                 </div>

                 <div class="help-block">
                     <asp:Label ID="lblPromoCodeValid" runat="server" Text="" Visible="false"></asp:Label>
                 </div>                                                                             
            </div>
           
       </div>

        <asp:Label ID="lblPromoDivClose" runat="server" Text="</div>"></asp:Label>  
            
        <asp:Panel ID="PanelPromoEmail" runat="server" Visible="false">              
        <div class="row">           
            <div class="col-md-12" id="promoEmail">
             <span style="color:green;"><small>You qualify for a discount on selected short courses, click the button below to receive email with promo code (email sent to the email address for which your account is associated with).</small></span>
            </div>
            <div class="col-md-4">
                 <div class="input-group">
                    <asp:Button ID="btnPromoCodeEmail" runat="server" Text="Send Promo Code" CssClass="btn btn-primary" OnClick="btnPromoCodeEmail_Click" />
                 </div>   
            </div>
            <div class="col-md-12">
                <asp:Label ID="lblEmailSent" runat="server"></asp:Label> 
            </div>
        </div>
        </asp:Panel>

        </asp:PlaceHolder>


        <asp:SqlDataSource ID="SqlDataSourceReg" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseRegistrationGetByPersonID" SelectCommandType="StoredProcedure" InsertCommand="PersonShortCoursesInsert" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="PersonID" Type="Int32" />
                <asp:Parameter Name="CourseID" Type="Int32" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
                <asp:Parameter Name="FeeTypeID" Type="Int32" />
                <asp:Parameter Name="Amount" Type="Decimal" />
                <asp:Parameter Name="Notes" Type="String" />
                <asp:Parameter Direction="InputOutput" Name="Fail" Type="String" Size="500" DefaultValue="No" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="PersonID" Type="Int32" />
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceFees" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ShortCourseListGet" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ConferenceID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceSpecialNeeds" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="PersonSpecialNeedsUpdate" SelectCommandType="StoredProcedure" UpdateCommand="PersonSpecialNeedsUpdate" UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:Parameter Name="PersonID" Type="Int32" />
                <asp:Parameter Name="SpecialNeeds" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <div class="form-group">
            <div class="container">
<asp:PlaceHolder ID="PlaceHolder1" runat="server">
</asp:PlaceHolder>
                <div class="row">
                    <div class="col-md-12">
                        &nbsp;</div>
                    </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:Panel ID="pnlDefunctSpecialNeeds" Visible="false" runat="server">
                            <asp:Label ID="lblSpecialNeeds" runat="server" Text="Special Needs" AssociatedControlID="txtSpecialNeeds"></asp:Label> <small>(e.g. dietary, wheelchair access)</small>
                            <asp:TextBox ID="txtSpecialNeeds" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
                        </asp:Panel>
                        <div class="alert alert-warning" role="alert">
                            <p>Light refreshments will be served for all Short Courses. Lunch is not included for 8-hour courses, the course will break for lunch. Food and beverage options are selected to accommodate a wide range of culinary tastes and dietary restrictions, however, due to the large number of people being served at each function, special dietary requests may not be met. If you have severe food allergies please contact us at <asp:Label ID="lblEmail" runat="server"></asp:Label> to discuss your dietary needs. Also, please notify us if you have other special needs (e.g., wheelchair access).</p>
                        </div>
                    </div>
                    </div>
                 
                <div class="row">
                    <div class="col-md-12">
                        <asp:Label ID="lblMessage" runat="server" Text="You must select a course" CssClass="text-danger" Visible="False"></asp:Label>
                        <asp:Literal ID="ltlMessage" runat="server" Visible="False"></asp:Literal>
                        <asp:Label ID="lblAlert" runat="server" Text="" CssClass="text-danger"  Visible="False"></asp:Label>
                        
                    </div>
                    </div>
            <div class="row">
                    <div class="col-md-12">
                        &nbsp;</div>
                    </div>
                <div class="row">
                    <div class="col-md-2">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary btn-block" />
                        <asp:Button ID="btnAlert" runat="server" Text="Update Form" CssClass="btn btn-primary btn-block" Visible="False" CausesValidation="False" />
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnClear" runat="server" Text="Clear Form" CssClass="btn btn-default btn-block"  /></div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnCtrls" runat="server" />

    </asp:Panel>
        </ContentTemplate></asp:UpdatePanel>
</asp:Content>
