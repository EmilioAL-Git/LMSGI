<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

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
        <!-- Título simple -->
        <h1>HACIENDA-RENTA 2024</h1>

        <!-- Período -->
        <p>Del <xsl:value-of select="plazo/inicio"/> al <xsl:value-of select="plazo/fin"/></p>

        <!-- Contacto -->
        <p>Contactar con: <a href="{nombre/@contacto}"><xsl:value-of select="nombre"/></a></p>

        <!-- Contar declarantes -->
        <h1>Total de declarantes: <xsl:value-of select="count(declarantes/particular) + count(declarantes/empresa)"/></h1>

        <!-- Lista de particulares -->
        <h1>Particulares:</h1>
        <ol>
          <xsl:for-each select="declarantes/particular">
            <li><xsl:value-of select="nombre"/></li>
          </xsl:for-each>
        </ol>

        <!-- Tabla de empresas -->
        <h1>Empresas:</h1>
        <table>
          <tr>
            <th>NIF</th>
            <th>Nombre</th>
            <th>Domicilio</th>
            <th>Resultado</th>
          </tr>
          <xsl:for-each select="declarantes/empresa">
            <tr>
              <td class="fondo"><xsl:value-of select="@nif"/></td>
              <td class="fondo"><xsl:value-of select="nombre"/></td>
              <td class="fondo">
                <xsl:value-of select="domicilio/calle"/>, 
                <xsl:value-of select="domicilio/capital"/>
                <xsl:if test="domicilio/pueblo">, <xsl:value-of select="domicilio/pueblo"/></xsl:if>
              </td>
              <td class="fondo"><xsl:value-of select="resultado"/> euros</td>
            </tr>
          </xsl:for-each>
        </table>

        <!-- Declarantes que pagan -->
        <h1>Declarantes que pagan:</h1>
        <p>
          <xsl:for-each select="declarantes/particular | declarantes/empresa">
            <xsl:if test="resultado/@pagar = 'si'">
              <xsl:value-of select="nombre"/> paga <xsl:value-of select="resultado"/> euros<br/>
            </xsl:if>
          </xsl:for-each>
        </p>

        <!-- Declarante en revisión -->
        <h1>Declarante en revisión:</h1>
        <p>
          NIF: <xsl:value-of select="revision/@declarantes"/><br/>
          Nombre: <xsl:for-each select="declarantes/empresa">
            <xsl:if test="@nif = /renta/revision/@declarantes">
              <xsl:value-of select="nombre"/>
            </xsl:if>
          </xsl:for-each>
        </p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>