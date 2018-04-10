<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PosicionamentoSegmento.aspx.cs" Inherits="UI.DadoVariavel.PosicionamentoSegmento" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register src="../Controles/Menu.ascx" tagname="Menu" tagprefix="uc1" %>
<%@ Register src="../Controles/MenuTopo.ascx" tagname="MenuTopo" tagprefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >


<!-- **** DESIGN INFORMATION: start head **** --> 
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <script type="text/javascript" src="../Js/menu-for-applications.js"></script>
    <link href="../Css/Css.css" rel="stylesheet" type="text/css" />
    <link href="../Css/MenuBar.css" rel="stylesheet" media="screen" type="text/css" />
    <script type="text/javascript" src="../Js/Includes.js"></script>    
</head>
<!-- **** DESIGN INFORMATION: end /head **** --> 


<!-- **** DESIGN INFORMATION: BODY **** --> 
<body>
<form id="form1" runat="server" >
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


<!-- *******************************************************************************
 DESIGN INFORMATION: start div top 
******************************************************************************** -->
<div id="framecontent">
	<div id="toplogo"><img src="../Images/topo/logo.jpg"></div>
    <div id="toplogin">
    <ul>
    	<li><b><asp:Label ID="lblLogin" runat="server" Text="Rodrigo Nobrega"></asp:Label></b></li>
        <li><asp:Label ID="lblEmpresa" runat="server" Text="W IT Solutions"></asp:Label></li>
    </ul>
    </div>   
    <div id="topmenu"><uc2:MenuTopo ID="MenuTopo1" runat="server" /></div>
</div>    
<!-- *******************************************************************************
 DESIGN INFORMATION: end div top 
******************************************************************************** -->



<!-- *******************************************************************************
 DESIGN INFORMATION: start div content 
******************************************************************************** --> 
<div id="maincontent">
<div class="contentform">
    
    
<!-- *******************************************************************************
 DESIGN INFORMATION: start form 
******************************************************************************** -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td id="formtitulo"><img src="../Images/div_titulo.gif" align="absmiddle"/>Dados Vari�veis</td>
  </tr>
  <tr>
    <td>
    <table width="99%" align="right" border="0" cellspacing="3" cellpadding="0" id="formfont">
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td width="25%">Campanha:</td>
          <td width="25%">Modelo:</td>
          <td width="25%">&nbsp;</td>
          <td width="25%">&nbsp;</td>
        </tr>
        <tr>
          <td>
            <asp:DropDownList ID="ddlCampanha" runat="server" CssClass="txtbox" Width="95%"></asp:DropDownList>
          </td>
          <td><asp:DropDownList ID="ddlModelo" runat="server" CssClass="txtbox" Width="95%"></asp:DropDownList></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>    
    </td>
  </tr>
  <tr>
    <td id="botoes">&nbsp;</td>
  </tr>
  <tr>
    <td>
<!-- *******************************************************************************
 DESIGN INFORMATION: start grid
******************************************************************************** -->        
    <div id="gridform">
        <asp:GridView ID="grvSegmentos" runat="server" AutoGenerateColumns="False" GridLines="none"
        Width="100%" AllowPaging="false" CellPadding="4">
          <FooterStyle/>
          <RowStyle CssClass="grid_line_01" />
          <Columns>
          <asp:TemplateField ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle">
            <ItemTemplate>
              <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Icones/editar.gif" ToolTip="Editar"/></ItemTemplate>
            <HeaderStyle CssClass="grid_tittle"></HeaderStyle>
            <ItemStyle Width="2%"></ItemStyle>
          </asp:TemplateField>
          <asp:TemplateField ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle_div">
            <ItemTemplate>
              <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Icones/excluir.gif" ToolTip="Excluir" /></ItemTemplate>
            <HeaderStyle CssClass="grid_tittle_div"></HeaderStyle>
            <ItemStyle Width="2%"></ItemStyle>
          </asp:TemplateField>
          <asp:BoundField HeaderText="C�digo" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle_div" HeaderStyle-Width="10%">
            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
          </asp:BoundField>
          <asp:BoundField HeaderText="Descri��o" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle" HeaderStyle-Width="90%">
            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
          </asp:BoundField>
          </Columns>
          <HeaderStyle/>
          <AlternatingRowStyle CssClass="grid_line_02"/>
        </asp:GridView>
      </div>
<!-- *******************************************************************************
 DESIGN INFORMATION: end grid
******************************************************************************** -->      
</td>
  </tr>
  <tr>
    <td><table width="99%" align="right" border="0" cellspacing="3" cellpadding="0" id="formfont">
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="25%">Segmento:</td>
        <td width="25%">Descri��o:</td>
        <td width="25%">&nbsp;</td>
        <td width="25%">&nbsp;</td>
      </tr>
      <tr>
        <td><asp:TextBox ID="txtSegmento" runat="server" CssClass="txtbox" Width="95%"/></td>
        <td><asp:TextBox ID="txtDescricao" runat="server" CssClass="txtbox" Width="95%"/></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td>
    <!-- *******************************************************************************
 DESIGN INFORMATION: start grid
******************************************************************************** -->        
    <div id="gridform">
        <asp:GridView ID="grvFatores" runat="server" AutoGenerateColumns="False" GridLines="none"
        Width="100%" AllowPaging="false" CellPadding="4">
          <FooterStyle/>
          <RowStyle CssClass="grid_line_01" />
          <Columns>
          <asp:TemplateField ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle">
            <ItemTemplate>
              <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/Icones/editar.gif" ToolTip="Editar"/></ItemTemplate>
            <HeaderStyle CssClass="grid_tittle"></HeaderStyle>
            <ItemStyle Width="2%"></ItemStyle>
          </asp:TemplateField>
          <asp:TemplateField ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle_div">
            <ItemTemplate>
              <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Images/Icones/excluir.gif" ToolTip="Excluir" /></ItemTemplate>
            <HeaderStyle CssClass="grid_tittle_div"></HeaderStyle>
            <ItemStyle Width="2%"></ItemStyle>
          </asp:TemplateField>
          <asp:BoundField HeaderText="Segmento" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle_div" HeaderStyle-Width="10%">
            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
          </asp:BoundField>
          <asp:BoundField HeaderText="Descri��o" HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="grid_tittle" HeaderStyle-Width="90%">
            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
          </asp:BoundField>
          </Columns>
          <HeaderStyle/>
          <AlternatingRowStyle CssClass="grid_line_02"/>
        </asp:GridView>
      </div>
<!-- *******************************************************************************
 DESIGN INFORMATION: end grid
******************************************************************************** -->
    </td>
  </tr>
</table>
<!-- *******************************************************************************
 DESIGN INFORMATION: end form 
******************************************************************************** -->  


 
</div>
</div>
</form>
<!-- *******************************************************************************
 DESIGN INFORMATION: end div content 
******************************************************************************** --> 


<!-- *******************************************************************************
 DESIGN INFORMATION: start script page frames 
******************************************************************************** -->
    <script type="text/javascript">
        var menuModel = new DHTMLSuite.menuModel();
        DHTMLSuite.configObj.setCssPath('css/');
        menuModel.addItemsFromMarkup('menuModel');
        menuModel.setMainMenuGroupWidth(00);
        menuModel.init();
        var menuBar = new DHTMLSuite.menuBar();
        menuBar.addMenuItems(menuModel);
        menuBar.setTarget('menuDiv');
        menuBar.init();	
    </script>
<!-- *******************************************************************************
 DESIGN INFORMATION: start script page frames 
******************************************************************************** -->
</body>
</html>
<!-- **** DESIGN INFORMATION: BODY **** -->