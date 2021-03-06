<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="width" select="400"/>
<xsl:param name="height" select="400"/>

<xsl:template name="main" match="/">
  <div>
    <!-- Set Style -->
    <style type="text/css" media="all">
      td.cell {
        width:  <xsl:value-of select="$width * 0.1"/>px;
        height: <xsl:value-of select="$height * 0.1"/>px;
        border: 2px solid #000;
        background-color: #CCCCCC;
        align: center;
        valign: middle;
      }
      table.board {
        background-color: #000000;
      }
      img.piece {
        width: <xsl:value-of select="$width * 0.9 * 0.1"/>px;
        height: <xsl:value-of select="$height * 0.9 * 0.1"/>px;        
      }
    </style>
    
    <!-- Draw Board -->
    <xsl:call-template name="board">
      <xsl:with-param name="cols" select="10"/>
      <xsl:with-param name="rows" select="10"/>
    </xsl:call-template>		    
  </div>  
</xsl:template>

<xsl:template name="cell" match="state/fact">
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/> 
  
  <xsl:param name="col_char" select="translate(translate(translate(translate(translate(translate(translate(translate(translate($col,1,'a'),2,'b'),3,'c'),4,'d'),5,'e'),6,'f'),7,'g'),8,'h'),9,'i')"/>

  <td class="cell">

  <center>
  <xsl:choose>
    <xsl:when test="$col = '10'">
      <xsl:if test="//fact[relation='cell' and argument[1]='j' and argument[2]=$row and argument[3]='white']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Bishop.png"/> </xsl:if>
      <xsl:if test="//fact[relation='cell' and argument[1]='j' and argument[2]=$row and argument[3]='black']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Bishop.png"/> </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="//fact[relation='cell' and argument[1]=$col_char and argument[2]=$row and argument[3]='white']"> <img class="piece" src="&ROOT;/resources/images/chess/White_Bishop.png"/> </xsl:if>
      <xsl:if test="//fact[relation='cell' and argument[1]=$col_char and argument[2]=$row and argument[3]='black']"> <img class="piece" src="&ROOT;/resources/images/chess/Black_Bishop.png"/> </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
  </center>
  
  </td>  
</xsl:template>

<xsl:template name="board_row">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>
  <xsl:param name="col" select="1"/>
  
  <xsl:call-template name="cell">
    <xsl:with-param name="row" select="$row"/>
    <xsl:with-param name="col" select="$col"/>
  </xsl:call-template>

  <xsl:if test="$col &lt; $cols">
    <xsl:call-template name="board_row">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row"/>
      <xsl:with-param name="col" select="$col + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="board_rows">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>  
  <xsl:param name="row" select="1"/>

  <tr>
  <xsl:call-template name="board_row">
    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
    <xsl:with-param name="row" select="$row"/>
  </xsl:call-template>
  </tr>

  <xsl:if test="$row &lt; $rows">
    <xsl:call-template name="board_rows">
      <xsl:with-param name="cols" select="$cols"/>
      <xsl:with-param name="rows" select="$rows"/>
      <xsl:with-param name="row" select="$row + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="board">
  <xsl:param name="cols" select="1"/>
  <xsl:param name="rows" select="1"/>

  <table class="board">
  <xsl:call-template name="board_rows">
    <xsl:with-param name="cols" select="$cols"/>
    <xsl:with-param name="rows" select="$rows"/>
  </xsl:call-template>
  </table>
</xsl:template>

</xsl:stylesheet>
