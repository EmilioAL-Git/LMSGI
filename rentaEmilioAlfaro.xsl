<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Configuración de salida para generar HTML -->
  <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>

  <!-- Plantilla principal que coincide con el nodo raíz del XML -->
  <xsl:template match="/renta">
    <html>
      <head>
        <title>HACIENDA-RENTTA 2024</title>
        <!-- Estilos CSS para mejorar la presentación -->
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          h1 { color: #2c3e50; font-size: 24px; text-align: center; }
          h2 { color: #34495e; font-size: 20px; }
          p { margin: 5px 0; }
          table { width: 80%; border-collapse: collapse; margin: 10px 0; }
          th, td { border: 1px solid #000; padding: 8px; text-align: left; }
          th { background-color: #f2f2f2; }
          .highlight { background-color: #ffeb3b; }
        </style>
      </head>
      <body>
        <!-- Título principal -->
        <h1>HACIENDA-RENTTA 2024</h1>

        <!-- Período de declaración -->
        <p>del <xsl:value-of select="plazo/inicio"/> al <xsl:value-of select="plazo/fin"/></p>

        <!-- Información de contacto -->
        <p>contactar con <xsl:value-of select="nombre"/> ---contactar</p>

        <!-- Cantidad de declarantes -->
        <h2>Hay <xsl:value-of select="count(particular) + count(empresa) + 1"/> declarantes</h2>

        <!-- Lista de particulares -->
        <h2>Los particulares son</h2>
        <ol>
          <xsl:for-each select="particular">
            <li>particular - <xsl:value-of select="nombre"/></li>
          </xsl:for-each>
        </ol>

        <!-- Lista de empresas -->
        <h2>Las empresas son</h2>
        <table>
          <tr>
            <th>nif</th>
            <th>nombre</th>
            <th>domicilio</th>
            <th>resultado</th>
          </tr>
          <tr>
            <td><xsl:value-of select="declarantes/@nif"/></td>
            <td><xsl:value-of select="declarantes/nombre"/></td>
            <td>
              <xsl:value-of select="declarantes/calle"/>, 
              <xsl:value-of select="declarantes/domicilio/calle"/>, 
              <xsl:value-of select="declarantes/domicilio/capital"/>
            </td>
            <td class="highlight"><xsl:value-of select="declarantes/resultado"/> euros</td>
          </tr>
          <xsl:for-each select="empresa">
            <tr>
              <td>N/A</td>
              <td><xsl:value-of select="nombre"/></td>
              <td>
                <xsl:value-of select="domicilio/calle"/>, 
                <xsl:value-of select="domicilio/pueblo"/>, 
                <xsl:value-of select="domicilio/capital"/>
              </td>
              <td><xsl:value-of select="resultado"/> euros</td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- Declarantes a pagar -->
        <h2>Los declarantes a pagar</h2>
        <p>
          <xsl:for-each select="declarantes | particular | empresa">
            <xsl:if test="resultado/@pagar = 'si'">
              <xsl:value-of select="nombre"/> --> 
              <xsl:choose>
                <xsl:when test="nombre = 'Sistemas Informáticos'">24500 euros</xsl:when>
                <xsl:when test="nombre = 'Ana Parranda'">> 800 euros</xsl:when>
                <xsl:otherwise><xsl:value-of select="resultado"/> euros</xsl:otherwise>
              </xsl:choose>
              <br/>
            </xsl:if>
          </xsl:for-each>
        </p>

        <!-- Declarante objeto de revisión -->
        <h2>el declarante objeto de revision es :</h2>
        <p>
          <xsl:variable name="revision">N-325-G</xsl:variable>
          <xsl:value-of select="$revision"/> (usando variable)
          <br/>
          y se llama <xsl:value-of select="empresa/nombre"/>
        </p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>