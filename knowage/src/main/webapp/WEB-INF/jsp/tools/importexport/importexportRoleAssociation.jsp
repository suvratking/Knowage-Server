<%--
Knowage, Open Source Business Intelligence suite
Copyright (C) 2016 Engineering Ingegneria Informatica S.p.A.

Knowage is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

Knowage is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--%>


<%@ include file="/WEB-INF/jsp/commons/portlet_base.jsp"%>

<%@ page import="it.eng.spago.navigation.LightNavigationManager,it.eng.spagobi.tools.importexportOLD.ImportExportConstants,java.util.List,java.util.Iterator,it.eng.spagobi.commons.bo.Role" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="it.eng.spagobi.tools.importexportOLD.*"%>

<script type="text/javascript" src="<%=linkProto%>"></script>
<script type="text/javascript" src="<%=linkProtoWin%>"></script>
<script type="text/javascript" src="<%=linkProtoEff%>"></script>
<link href="<%=linkProtoDefThem%>" rel="stylesheet" type="text/css"/>
<link href="<%=linkProtoAlphaThem%>" rel="stylesheet" type="text/css"/>

<%  
	SourceBean moduleResponse = (SourceBean)aServiceResponse.getAttribute("ImportExportModule"); 
	List curRoles = (List)moduleResponse.getAttribute(ImportExportConstants.LIST_CURRENT_ROLES);
	List expRoles = (List)moduleResponse.getAttribute(ImportExportConstants.LIST_EXPORTED_ROLES);
    Iterator iterExpRoles = expRoles.iterator();
   
	Map exitUrlPars = new HashMap();
	exitUrlPars.put("PAGE", "ImportExportPage");
	exitUrlPars.put("MESSAGEDET", ImportExportConstants.IMPEXP_EXIT);
	exitUrlPars.put(LightNavigationManager.LIGHT_NAVIGATOR_DISABLED, "true");
	String exitUrl = urlBuilder.getUrl(request, exitUrlPars);
    
	Map formUrlPars = new HashMap();
	formUrlPars.put("PAGE", "ImportExportPage");
	formUrlPars.put("MESSAGEDET", ImportExportConstants.IMPEXP_ROLE_ASSOCIATION);
	formUrlPars.put(LightNavigationManager.LIGHT_NAVIGATOR_DISABLED, "true");
	String formUrl = urlBuilder.getUrl(request, formUrlPars);
	
	IImportManager impManager = (IImportManager)aSessionContainer.getAttribute(ImportExportConstants.IMPORT_MANAGER);
	UserAssociationsKeeper usrAssKeep = impManager.getUserAssociation();
%>


<script>

	var infopanelopen = false;
	var winInfo = null;
	
	function opencloseInfoPanel() {
		if(!infopanelopen){
			infopanelopen = true;
		 	openInfo();
		 }
	}
	
	function openInfo(){
		if(winInfo==null) {
		 	winInfo = new Window('winInfo', {className: "alphacube", title:"<spagobi:message key="help"  bundle="messages"/>", width:680, height:150, destroyOnClose: false});
		 	winInfo.setContent('infodiv', false, false);
		 	winInfo.showCenter(true);
		 } else {
			winInfo.showCenter(true);
		 }
	}
	
	observerWInfo = { onClose: function(eventName, win) {
			if (win == winInfo) {
			 	infopanelopen = false;
			 }
		}
	}
	
	Windows.addObserver(observerWInfo);

</script>
		
		
<div id='infodiv' style='display:none;'>
	<ul style="color:#074B88;">
			<li><spagobi:message key = "SBISet.impexp.rolerule1"  bundle="component_impexp_messages"/></li>
			<li><spagobi:message key = "SBISet.impexp.rolerule2"  bundle="component_impexp_messages"/></li>
			<li><spagobi:message key = "SBISet.impexp.rolerule3"  bundle="component_impexp_messages"/></li>
	</ul>
</div>	



<form method='POST' action='<%=formUrl%>' id='roleAssForm' name='roleAssForm'>

	<table class='header-table-portlet-section'>
		<tr class='header-row-portlet-section'>
			<td class='header-title-column-portlet-section' style='vertical-align:middle;padding-left:5px;'>
				<spagobi:message key = "SBISet.roleAssociation"  bundle="component_impexp_messages"/>
			</td>
			<td class='header-empty-column-portlet-section'>&nbsp;</td>
			<td class='header-button-column-portlet-section'>
				<a href='javascript:opencloseInfoPanel()'> 
	      			<img class='header-button-image-portlet-section' 
	      				 title='<spagobi:message key="help"  bundle="messages"/>' 
	      				 src='<%=urlBuilder.getResourceLinkByTheme(request, "/img/question32.gif", currTheme)%>' 
	      				 alt='<spagobi:message key="help"  bundle="messages"/>' />
				</a>
			</td>		
			<td class='header-empty-column-portlet-section'>&nbsp;</td>
			<td class='header-button-column-portlet-section'>
				<a href='javascript:document.getElementById("roleAssForm").submit()'> 
	      			<img class='header-button-image-portlet-section' 
	      				 title='<spagobi:message key="Sbi.next"  bundle="component_impexp_messages"/>' 
	      				 src='<%=urlBuilder.getResourceLinkByTheme(request, "/img/tools/importexport/next.gif", currTheme)%>' 
	      				 alt='<spagobi:message key="Sbi.next"  bundle="component_impexp_messages"/>' />
				</a>
			</td>
			<td class='header-empty-column-portlet-section'>&nbsp;</td>
			<td class='header-button-column-portlet-section'>
				<a href='<%=exitUrl%>'> 
	      			<img class='header-button-image-portlet-section' 
	      				 title='<spagobi:message key = "Sbi.exit"  bundle="component_impexp_messages"/>' 
	      				 src='<%=urlBuilder.getResourceLinkByTheme(request, "/img/tools/importexport/stop.gif", currTheme)%>' 
	      				 alt='<spagobi:message key = "Sbi.exit"  bundle="component_impexp_messages"/>' />
				</a>
			</td>
		</tr>
	</table>



	<div class="div_background_no_img">
		<div class="box padding5" >
			<table>
				<tr>
					<td class='portlet-section-header'><spagobi:message key = "SBISet.impexp.exportedRoles"  bundle="component_impexp_messages"/></td>
					<td class='portlet-section-header'><spagobi:message key = "SBISet.impexp.currentRoles"  bundle="component_impexp_messages"/></td>
				</tr>
				<tr>
					<td colspan="2">&nbsp;</td>
				</tr>
				<%if(expRoles.isEmpty()) { %>
				<tr>
					<td colspan="2" style="color:#074B88;"><spagobi:message key="SBISet.impexp.noRoleExported"  bundle="component_impexp_messages"/></td>
				</tr>
				<% } %>
			    <%
			    while(iterExpRoles.hasNext()) {
			    	Role role = (Role)iterExpRoles.next();
			    %>
				<tr>
					<td class='portlet-form-field-label'>
					<%
					  String rolename = role.getName();
						if((rolename!=null) && (rolename.length() > 50)) {
						   rolename = rolename.substring(0, 50);
						   rolename += "...";
						}
					%>
	            		<span title="<%=role.getName()%>" alt="<%=role.getName()%>"><%=rolename%></span>
	        		</td>
					<td>
					    <input type="hidden" name="expRole" value="<%=role.getId()%>" />
					    <% 
							Iterator iterCurRoles = curRoles.iterator();
							boolean existDefault = false;
							Integer idAssRole = null;
							while(iterCurRoles.hasNext()) {
								Role roleCur = (Role)iterCurRoles.next();
								if(roleCur.getName().equalsIgnoreCase(role.getName())){
									existDefault = true;
									idAssRole = roleCur.getId();
									break;
								}
							}
						%>
						<%
							String associatedMsg = "";
							boolean isAssociated = false;
							if(existDefault) {
						%>
						<input type="hidden" name="roleAssociated<%=role.getId()%>" value="<%=idAssRole%>"> 
						<select style="width:250px" disabled>
						<%
							} else { 
						%>
						<select style="width:250px" name="roleAssociated<%=role.getId()%>" >
						<%
							}					
						%>	
							<option value="">
								<spagobi:message key="Sbi.selectcombo"  bundle="component_impexp_messages"/>
							</option>
							<% 
								iterCurRoles = curRoles.iterator();
								String selected = null;
								while(iterCurRoles.hasNext()) {
									selected = "";
									Role roleCur = (Role)iterCurRoles.next();
									if(existDefault) {
										if(roleCur.getName().equalsIgnoreCase(role.getName())) {
											selected=" selected ";
										}
									} else {
										String roleAss = usrAssKeep.getAssociatedRole(role.getName());
										if( (roleAss!=null) &&  roleCur.getName().equals(roleAss)) {
											selected=" selected ";
											isAssociated = true;
										}
									}
							%>
							<option value='<%=roleCur.getId()%>' <%=selected%>><%=roleCur.getName()%></option>
							<% } %>
						</select>
						<%
						if (isAssociated) {
							%>
							<img title='<spagobi:message key = "Sbi.associated"  bundle="component_impexp_messages"/>' 
	      				 		src='<%=urlBuilder.getResourceLinkByTheme(request, "/img/tools/importexport/associated.gif", currTheme)%>' 
	      				 		alt='<spagobi:message key = "Sbi.associated"  bundle="component_impexp_messages"/>' />
							<%
						}
						%>
					</td>
				</tr>
				<% } %>
			</table>
		</div>
	</div>
	
	
</form>
