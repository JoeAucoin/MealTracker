﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="GIBS.Modules.MealTracker.Settings" %>


<!-- uncomment the code below to start using the DNN Form pattern to create and update settings -->
 

<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>

	<h2 id="dnnSitePanel-BasicSettings" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded"><%=LocalizeString("BasicSettings")%></a></h2>
	<fieldset>
    <div class="dnnFormItem">
        <dnn:Label runat="server" ID="lbljQueryUI" ControlName="txtjQueryUI" ResourceKey="lbljQueryUI" Suffix=":" />
        <asp:Textbox ID="txtjQueryUI" runat="server" />
           
     </div>	


	<div class="dnnFormItem">
        <dnn:Label runat="server" ID="lblLocationsList" ControlName="Locations" ResourceKey="lblLocationsList" Suffix=":" />
        <asp:DropDownList ID="ddlLocationList" runat="server" CssClass="form-control input-lg">
    </asp:DropDownList>	
           
     </div>
	<div class="dnnFormItem">
        <dnn:Label runat="server" ID="lblSeatingList" ControlName="ddlSeatingList" ResourceKey="lblSeatingList" Suffix=":" />
            <asp:DropDownList ID="ddlSeatingList" runat="server" CssClass="form-control input-lg">
    </asp:DropDownList>	
           
     </div>	

    </fieldset>


