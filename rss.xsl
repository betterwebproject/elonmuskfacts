<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:svg="http://www.w3.org/2000/svg">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  
  <xsl:template match="/">
    <html lang="en-US">
      <head>         
        <meta charset="utf-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, interactive-widget=resizes-content"/>
        <meta name="color-scheme" content="dark"/>
        <link rel="preload" fetchpriority="high" href="/assets/images/header_img.webp" as="image" type="image/webp"/>
        <link rel="preload" href="/assets/type/mdnichrome_black.woff2" as="font" type="font/woff2" crossorigin="anonymous"/>
        <link rel="stylesheet" href="/assets/css/style.css"/> 
        <link rel="icon" href="/favicon.ico" type="image/x-icon" sizes="32x32"/>
        <link rel="icon" href="/favicon.svg" type="image/svg+xml" sizes="any"/>
        <link rel="apple-touch-icon" href="/assets/icons/apple_touch_icon.png" type="image/png"/>
        <link rel="manifest" href="/manifest.json" type="application/json"/>
        <title><xsl:value-of select="rss/channel/title"/> RSS Feed - Elon Musk Facts™</title>
        <style>.intro{margin-block-end:var(--space-3)}.item>*+*{margin-block-start:var(--space-1)}.subscribe{width:max-content;padding:.75rem 1rem;margin-block-start:var(--space-2);border:1px solid var(--border);border-radius:1rem;box-shadow:0 2px 6px rgba(0,0,0,.05);font-family:monospace;font-size:calc(.9rem + .15vw);word-break:break-all;background:var(--post-background);cursor:pointer;transition:background .2s ease}.subscribe:hover{background:var(--border)}.item{position:relative;width:100%;max-width:var(--max-width);padding:var(--space-2) 2.25rem;box-sizing:border;border-radius:1rem;background-color:var(--post-background);}.item+.item{margin-block-start:var(--space-3)}.item-title{font-family:var(--heading);font-size:var(--heading-1)}.tags{display:flex;flex-wrap:wrap}.tag{color:var(--accent)}@media(max-width:640px){.item{padding:var(--space-2) 1.5rem}}</style>
      </head>
      <body>
        <a href="#main-content" class="skip-link">Skip to content</a>
        <header class="header-small">
          <div class="header-image">
            <span class="vh">
              Image of billionaire space pirate Elon Musk posing on Mars in a Nazi spacesuit
            </span>
          </div>
          <span class="site-title-small">
            <a href="/" aria-label="Home">
              <svg class="arrow" viewBox="0 0 32 23.2" xmlns="http://www.w3.org/2000/svg">
                <g>
                  <path d="M29.91.03H32l-8.5 11.59L32 23.2h-2.09l-8.5-11.58z"/>
                  <path fill-opacity=".8" d="M24.56.03h2.09l-8.5 11.59 8.5 11.58h-2.09l-8.5-11.58z"/>
                  <path fill-opacity=".6" d="M19.21.03h2.09l-8.51 11.59 8.5 11.58h-2.08l-8.5-11.58z"/>
                  <path fill-opacity=".4" d="M13.86.03h2.09l-8.51 11.59 8.5 11.58h-2.08l-8.5-11.58z"/>
                  <path fill-opacity=".2" d="M8.5.03h2.1l-8.51 11.59 8.5 11.58h-2.08L0 11.62z"/>
                </g>
              </svg>
              <span>
                Elon Musk Facts<span class="sup">TM</span>
              </span>
            </a>
          </span>
        </header>
        <main id="main-content" tabindex="-1">
          <div class="intro page">
            <h1>RSS Feed</h1>
            <p>This is an RSS feed. Copy the URL below into your RSS reader to subscribe. Or scroll down for the latest facts.🔥</p>
            <p class="subscribe" onclick="copyToClipboard(this)"><xsl:value-of select="rss/channel/atom:link/@href"/></p>
          </div>
          
          <xsl:for-each select="rss/channel/item">
            <div class="item gradient-border">
              <h2 class="item-title">
                <a href="{link}"><xsl:value-of select="title"/></a>
              </h2>
              <div class="item-description">
                <xsl:value-of select="description" disable-output-escaping="yes"/>
              </div>
              <xsl:if test="category">
                <div class="tags">
                  <xsl:for-each select="category">
                    <span class="tag"><xsl:value-of select="."/></span>
                  </xsl:for-each>
                </div>
              </xsl:if>
            </div>
          </xsl:for-each>
          
        </main>
        <script>
          function copyToClipboard(element) {
            const text = element.textContent.trim();
            const originalText = text;
            const width = element.offsetWidth;
            
            navigator.clipboard.writeText(text).then(function() {
              element.style.width = width + 'px';
              element.textContent = 'URL copied!👍';
              setTimeout(function() {
                element.textContent = originalText;
                element.style.width = '';
              }, 1500);
            }).catch(function(err) {
              console.error('Failed to copy:', err);
            });
          }
        </script>
      </body>
    </html>
  </xsl:template>
  
</xsl:stylesheet>