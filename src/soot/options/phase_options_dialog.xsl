<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" indent="no"/>
    <xsl:strip-space elements="*"/>

<xsl:template match="/options">

/*
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * This class is generated automajically from xml - DO NOT EDIT - as
 * changes will be over written
 * 
 * The purpose of this class is to automajically generate a options
 * dialog in the event that options change
 * 
 * Taking options away - should not damage the dialog
 * Adding new sections of options - should not damage the dialog
 * Adding new otpions to sections (of known option type) - should not
 * damage the dialog
 *
 * Adding new option types will break the dialog (option type widgets
 * will need to be created)
 *
 */

package ca.mcgill.sable.soot.testing;

import org.eclipse.jface.dialogs.IDialogSettings;
import org.eclipse.swt.widgets.*;
import org.eclipse.swt.*;
import org.eclipse.swt.layout.*;
import ca.mcgill.sable.soot.SootPlugin;


public class PhaseOptionsDialog extends AbstractOptionsDialog {

	public PhaseOptionsDialog(Shell parentShell) {
		super(parentShell);
	}
	
	/**
	 * each section gets initialize as a stack layer in pageContainer
	 * the area containing the options
	 */ 
	protected void initializePageContainer() {

<!--add section pages-->
		<xsl:apply-templates mode="pageCon" select="/options/section"/>

		<xsl:for-each select="section">
		<!--<xsl:variable name="parent" select="translate(name[last()],'-. ','___')"/>-->
		<xsl:for-each select="phaseopt">
		<xsl:apply-templates mode="pageCon" select="phase"/>
		<xsl:for-each select="phase">
		<xsl:apply-templates mode="pageCon" select="sub_phase">
		<xsl:with-param name="parent" select="translate(alias[last()],'-. ','___')"/>
		</xsl:apply-templates>
		</xsl:for-each>
		</xsl:for-each>
		</xsl:for-each>
		
	}
	
	/**
	 * all options get saved as &#60;alias, value&#62; pair
	 */ 
	protected void okPressed() {
		IDialogSettings settings = SootPlugin.getDefault().getDialogSettings();
		<xsl:apply-templates mode="okPressed" select="/options/section"/>

		<xsl:for-each select="section">
		<!--<xsl:variable name="parent" select="translate(name[last()],'-. ','___')"/>-->
		<xsl:for-each select="phaseopt">
		<xsl:apply-templates mode="okPressed" select="phase"/>
		<xsl:for-each select="phase">
		<xsl:apply-templates mode="okPressed" select="sub_phase">
		<xsl:with-param name="parent" select="translate(alias[last()],'-. ','___')"/>
		</xsl:apply-templates>
		</xsl:for-each>
		</xsl:for-each>
		</xsl:for-each>


		super.okPressed();
				
	}


	/**
	 * the initial input of selection tree corresponds to each section
	 * at some point sections will have sub-sections which will be
	 * children of branches (ie phase - options)
	 */ 
	protected SootOption getInitialInput() {
		SootOption root = new SootOption("");
		SootOption parent;
		SootOption subParent;
		
<!--create branches for section pages-->
		<xsl:for-each select="section">
		SootOption <xsl:value-of select="translate(name[last()],'-. ','___')"/>_branch = new SootOption("<xsl:value-of select="name"/>");
		root.addChild(<xsl:value-of select="translate(name[last()],'-. ','___')"/>_branch);
		parent = <xsl:value-of select="translate(name[last()],'-. ','___')"/>_branch;		
		<xsl:for-each select="phaseopt">
		//<xsl:value-of select="name"/>
<!--create branches for phase pages-->
			<xsl:for-each select="phase">
			<xsl:variable name="parent" select="translate(alias[last()],'-. ','___')"/>
			//<xsl:value-of select="name"/>
			SootOption <xsl:value-of select="translate(alias[last()],'-. ','___')"/>_branch = new SootOption("<xsl:value-of select="name"/>");
			parent.addChild(<xsl:value-of select="translate(alias[last()],'-. ','___')"/>_branch);
			subParent = <xsl:value-of select="translate(alias[last()],'-. ','___')"/>_branch;
<!--create branches for sub-phase pages-->
			<xsl:for-each select="sub_phase">
			SootOption <xsl:value-of select="$parent"/>_<xsl:value-of select="translate(alias[last()],'-. ','___')"/>_branch = new SootOption("<xsl:value-of select="name"/>");
			subParent.addChild(<xsl:value-of select="$parent"/>_<xsl:value-of select="translate(alias[last()],'-. ','___')"/>_branch);
<!--create branches for sub-phase sub-section pages-->
			</xsl:for-each>
			</xsl:for-each>
		</xsl:for-each>
		
		</xsl:for-each>
		return root;
	
	}


		<xsl:apply-templates mode="objCreation" select="/options/section"/>

		<xsl:for-each select="section">
		<!--<xsl:variable name="parent" select="translate(name[last()],'-. ','___')"/>-->
		<xsl:for-each select="phaseopt">
		<xsl:apply-templates mode="objCreation" select="phase"/>
		<xsl:for-each select="phase">
		
		<xsl:apply-templates mode="objCreation" select="sub_phase">
		<xsl:with-param name="parent" select="translate(alias[last()],'-. ','___')"/>
		</xsl:apply-templates>
		</xsl:for-each>
		</xsl:for-each>
		</xsl:for-each>
		

		<xsl:apply-templates mode="compInit" select="/options/section"/>
		<xsl:for-each select="section">
		
		<xsl:for-each select="phaseopt">
		
		<xsl:apply-templates mode="compInit" select="phase">
		<xsl:with-param name="parentAlias" select="alias"/>
		</xsl:apply-templates>
		
		<xsl:variable name="phaseAlias" select="alias"/>
		
		<xsl:for-each select="phase">
		
		<xsl:apply-templates mode="compInit" select="sub_phase">
		<xsl:with-param name="parent" select="translate(alias[last()],'-. ','___')"/>
		<xsl:with-param name="parentAlias" select="$phaseAlias"/>
		</xsl:apply-templates>
		
		</xsl:for-each>
		</xsl:for-each>
		</xsl:for-each>
		

}

</xsl:template>

<!--PAGE CONTAINER CREATION TEMPLATE-->

<xsl:template mode="pageCon" match="section|phase|sub_phase">
<xsl:param name="parent"/>
<xsl:variable name="translate(alias[last()],'-. ','___')" select="translate(name[last()],'-. ','___')|translate(alias[last()],'-. ','___')|translate(alias[last()],'-. ','___')"/>
Composite <xsl:copy-of select="$parent"/><xsl:copy-of select="$translate(alias[last()],'-. ','___')"/>Child = <xsl:copy-of select="$parent"/><xsl:copy-of select="$translate(alias[last()],'-. ','___')"/>Create(getPageContainer());
</xsl:template>
		
	
<!--OK PRESSED TEMPLATE-->

<xsl:template mode="okPressed" match="section|phase|sub_phase">
<xsl:param name="parent"/>
<xsl:variable name="subParent" select="translate(name[last()],'-. ','___')|translate(alias[last()],'-. ','___')|translate(alias[last()],'-. ','___')"/>


		<xsl:for-each select="boolopt|macroopt">
		settings.put(get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getAlias(), get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getButton().getSelection());
		</xsl:for-each>
		
		<xsl:for-each select="listopt">
		settings.put(get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getAlias(), get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getText().getText());
		</xsl:for-each>
		
		<xsl:for-each select="stropt|intopt|flopt">
		settings.put(get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getAlias(), get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getText().getText());
		</xsl:for-each>
		
		<xsl:for-each select="multiopt"> 
		settings.put(get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getAlias(), get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget().getSelectedAlias());
		</xsl:for-each>

</xsl:template>	



<!--COMPOSITE INITIALIZATION TEMPLATE-->
<xsl:template mode="compInit" match="section|phase|sub_phase">

<xsl:param name="parent"/>
<xsl:variable name="subParent" select="translate(name[last()],'-. ','___')|translate(alias[last()],'-. ','___')|translate(alias[last()],'-. ','___')"/>
<xsl:variable name="name" select="name|name|name"/>
<xsl:param name="parentAlias"/>
<xsl:variable name="subParentAlias" select="alias|alias"/>

	private Composite <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/>Create(Composite parent) {
		Group editGroup = new Group(parent, SWT.NONE);
		GridLayout layout = new GridLayout();
		editGroup.setLayout(layout);
	
	 	editGroup.setText("<xsl:value-of select="$name"/>");
		
		
<!--Boolean and Macro Widget-->		
		<xsl:for-each select="boolopt|macroopt">
		set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(new BooleanOptionWidget(editGroup, SWT.NONE, new OptionData("<xsl:value-of select="name"/>", "<xsl:value-of select="$parentAlias"/>", "<xsl:value-of select="$subParentAlias"/>","<xsl:value-of select="alias"/>", "<xsl:value-of select="short_desc"/>")));
		</xsl:for-each>
		
<!--Multi Widget-->
		<xsl:for-each select="multiopt">
		
		OptionData [] data = new OptionData [] {
		<xsl:for-each select="value">
		new OptionData("<xsl:value-of select="value"/>",
		"<xsl:value-of select="alias"/>",
		"<xsl:value-of select="short_desc"/>",
		<xsl:if test="default">
		true),
		</xsl:if>
		<xsl:if test="not(default)">
		false),
		</xsl:if>
		
		</xsl:for-each>
		};
		
										
		set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(new MultiOptionWidget(editGroup, SWT.NONE, data, new OptionData("<xsl:value-of select="name"/>", "<xsl:value-of select="$parentAlias"/>", "<xsl:value-of select="$subParentAlias"/>","<xsl:value-of select="alias"/>", "<xsl:value-of select="short_desc"/>")));
		</xsl:for-each>
		
<!--Path Widget-->
		<xsl:for-each select="listopt">
		set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(new PathOptionWidget(editGroup, SWT.NONE, new OptionData("<xsl:value-of select="name"/>",  "<xsl:value-of select="$parentAlias"/>", "<xsl:value-of select="$subParentAlias"/>","<xsl:value-of select="alias"/>", "<xsl:value-of select="short_desc"/>")));
		</xsl:for-each>
		
<!--String, Int and Float Widget-->
		<xsl:for-each select="stropt|intopt|flopt">
		set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(new StringOptionWidget(editGroup, SWT.NONE, new OptionData("<xsl:value-of select="name"/>", "<xsl:value-of select="$parentAlias"/>", "<xsl:value-of select="$subParentAlias"/>","<xsl:value-of select="alias"/>", "<xsl:value-of select="short_desc"/>")));
		</xsl:for-each>
		
		return editGroup;
	}

</xsl:template>

<!--OBJECT CREATION TEMPLATE-->

<xsl:template mode="objCreation" match="section|phase|sub_phase">

<xsl:param name="parent"/>
<xsl:variable name="subParent" select="translate(name[last()],'-. ','___')|translate(alias[last()],'-. ','___')|translate(alias[last()],'-. ','___')"/>

<!--Boolean and Macro Object Creation-->

	<xsl:for-each select="boolopt|macroopt">
	private BooleanOptionWidget <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	
	private void set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(BooleanOptionWidget widget) {
		<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget = widget;
	}
	
	private BooleanOptionWidget get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget() {
		return <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	}	
	</xsl:for-each>

<!--Path Object Creation-->

	<xsl:for-each select="listopt">

	private PathOptionWidget <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	
	private void set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(PathOptionWidget widget) {
		<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget = widget;
	}
	
	private PathOptionWidget get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget() {
		return <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	}	
	
	</xsl:for-each>

<!--String, Int and Float Object Creation-->

	<xsl:for-each select="stropt|intopt|flopt">
	
	private StringOptionWidget <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	
	private void set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(StringOptionWidget widget) {
		<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget = widget;
	}
	
	private StringOptionWidget get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget() {
		return <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	}
	
	</xsl:for-each>

	
<!--Multi Object Creation-->

	<xsl:for-each select="multiopt">
	
	private MultiOptionWidget <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	
	private void set<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget(MultiOptionWidget widget) {
		<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget = widget;
	}
	
	private MultiOptionWidget get<xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget() {
		return <xsl:value-of select="$parent"/><xsl:value-of select="$subParent"/><xsl:value-of select="translate(alias[last()],'-. ','___')"/>_widget;
	}	
	
	</xsl:for-each>
	

</xsl:template>

</xsl:stylesheet>
