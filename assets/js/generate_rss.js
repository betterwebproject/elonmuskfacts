const fs = require('fs');
const path = require('path');

// Read posts.json - adjust path based on where script is located
const postsPath = path.join(__dirname, '../../posts.json');
const postsData = JSON.parse(fs.readFileSync(postsPath, 'utf8'));

// Filter out the alert and big-book posts, reverse to show newest first
const posts = postsData
  .filter(post => post.id !== 'alert' && post.id !== 'big-book')
  .reverse()
  .slice(0, 20); // Get latest 20 posts

// Helper function to strip HTML tags and decode entities
function stripHtml(html) {
  return html
    .replace(/<[^>]*>/g, '')
    .replace(/&shy;/g, '')
    .replace(/&[a-z]+;/gi, match => {
      const entities = {
        '&amp;': '&',
        '&lt;': '<',
        '&gt;': '>',
        '&quot;': '"',
        '&#39;': "'",
        '&ndash;': '–',
        '&mdash;': '—',
        '&hellip;': '…'
      };
      return entities[match] || match;
    });
}

// Helper function to escape XML special characters
function escapeXml(unsafe) {
  return unsafe
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

// Generate RSS items
const items = posts.map(post => {
  const plainText = stripHtml(post.text);
  const description = plainText.length > 300 
    ? plainText.substring(0, 300) + '...' 
    : plainText;
  
  const categories = post.tags
    .map(tag => `    <category>${escapeXml(tag)}</category>`)
    .join('\n');
  
  // Use post's date if available, otherwise use current date
  const pubDate = post.date ? new Date(post.date).toUTCString() : new Date().toUTCString();
  
  return `  <item>
    <title>${escapeXml(post.title)}</title>
    <link>https://elonmuskfacts.net/post.html?id=${post.id}</link>
    <guid>https://elonmuskfacts.net/post.html?id=${post.id}</guid>
    <pubDate>${pubDate}</pubDate>
    <description>${escapeXml(description)}</description>
${categories}
  </item>`;
}).join('\n\n');

// Generate RSS XML
const rssXml = `<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="rss.xsl"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Elon Musk Facts™</title>
    <link>https://elonmuskfacts.net</link>
    <description>Your Home for Elon Musk Fact Checks!</description>
    <language>en-US</language>
    <atom:link href="https://elonmuskfacts.net/rss.xml" rel="self" type="application/rss+xml"/>
    <lastBuildDate>${new Date().toUTCString()}</lastBuildDate>
    
${items}
    
  </channel>
</rss>`;

// Write RSS file
fs.writeFileSync('rss.xml', rssXml);
console.log('✅ RSS feed generated successfully!');
console.log(`📝 Generated ${posts.length} items`);
console.log('📍 Output: rss.xml');