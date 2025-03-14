<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Esto hace que la salida sea una página web -->
  <xsl:output method="html"/>

  <!-- Aquí empezamos a crear la página desde el nodo "renta" -->
  <xsl:template match="/renta">
    <html>
      <head>
        <title>HACIENDA-RENTA 2024</title>
        <style>
          body { font-family: Arial; margin: 20px; }
          h1 { text-align: left; }
          table { border: 1px solid black; }
          th, td { border: 1px solid black; padding: 5px; }
          .fondo { background-color: #ff9999; }
        </style>
      </head>
      <body>
        <!-- Título -->
        <h1>HACIENDA-RENTA 2024</h1>

        <!-- Período (lo sacamos del XML) -->
        <p>del <xsl:value-of select="plazo/inicio"/> al <xsl:value-of select="plazo/fin"/></p>

        <!-- Contacto (lo sacamos del XML) -->
        <p>contactar con <xsl:value-of select="nombre"/> ---contactar</p>

        <!-- Número de declarantes (contamos los nodos) -->
        <p>Hay <xsl:value-of select="count(particular) + count(empresa) + 1"/> declarantes</p>

        <!-- Lista de particulares (usamos un bucle para leerlos) -->
        <p>Los particulares son:</p>
        <ol>
          <xsl:for-each select="particular">
            <li>particular - <xsl:value-of select="nombre"/></li>
          </xsl:for-each>
        </ol>

        <!-- Lista de empresas (ponemos los datos del XML) -->
        <p>Las empresas son:</p>
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
            <td><xsl:value-of select="declarantes/calle"/>, <xsl:value-of select="declarantes/domicilio/calle"/></td>
            <td class="fondo"><xsl:value-of select="declarantes/resultado"/> euros</td>
          </tr>
          <tr>
            <td>N-325-G</td>
            <td><xsl:value-of select="empresa/nombre"/></td>
            <td><xsl:value-of select="empresa/domicilio/calle"/>, <xsl:value-of select="empresa/domicilio/pueblo"/></td>
            <td class="fondo"><xsl:value-of select="empresa/resultado"/> euros</td>
          </tr>
        </table>

        <!-- Declarantes a pagar (buscamos los que tienen pagar="si") -->
        <p>Los declarantes a pagar:</p>
        <p>
          <xsl:if test="declarantes/resultado/@pagar = 'si'">
            <xsl:value-of select="declarantes/nombre"/> --> <xsl:value-of select="declarantes/resultado"/> euros<br/>
          </xsl:if>
          <xsl:for-each select="particular">
            <xsl:if test="resultado/@pagar = 'si'">
              <xsl:value-of select="nombre"/> --> > 800 euros<br/>
            </xsl:if>
          </xsl:for-each>
        </p>

        <!-- Declarante objeto de revisión -->
        <p>el declarante objeto de revision es :</p>
        <p>N-325-G <br/>y se llama <xsl:value-of select="empresa/nombre"/></p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>