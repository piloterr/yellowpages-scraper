<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Yellowpages Scraper API by Piloterr – scrape Yellowpages data as JSON" width="100%"></a>
</p>

# Yellowpages Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Yellowpages Scraper API** lets you extract public data from Yellowpages as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Yellowpages Business API** — Extract a full Yellow Pages business profile from a listing URL, including phone, website, categories, and ratings via browser rendering.
- **Yellowpages Search API** — Search Yellow Pages businesses from a full search URL and retrieve names, phones, addresses, ratings, opening hours, and pagination via browser rendering.

Use it for lead generation, CRM enrichment, market mapping, investment research or job market analytics.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Yellowpages Business API](#yellowpages-business-api) | `/v2/yellowpages/business` | 2 | Extract a full Yellow Pages business profile from a listing URL, including phone, website, categories, and ratings via browser rendering. |
| [Yellowpages Search API](#yellowpages-search-api) | `/v2/yellowpages/search` | 2 | Search Yellow Pages businesses from a full search URL and retrieve names, phones, addresses, ratings, opening hours, and pagination via browser rendering. |

## Table of contents

- [How it works](#how-it-works)
- [Yellowpages Business API](#yellowpages-business-api)
- [Yellowpages Search API](#yellowpages-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Official SDKs](#official-sdks)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Yellowpages Business API

Extract a full Yellow Pages business profile from a listing URL, including phone, website, categories, and ratings via browser rendering.

`GET | POST https://api.piloterr.com/v2/yellowpages/business` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Full Yellow Pages business listing URL. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/yellowpages/business",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.yellowpages.com/los-angeles-ca/mip/anawalt-lumber-13945594?lid=1002108313121",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type YellowpagesBusiness = {
  name?: string;
  phone?: string;
  rating?: string;
  address?: string;
  website?: string;
  categories?: string[];
  rating_count?: number;
};

const params = new URLSearchParams({
  "query": "https://www.yellowpages.com/los-angeles-ca/mip/anawalt-lumber-13945594?lid=1002108313121",
});

const response = await fetch(`https://api.piloterr.com/v2/yellowpages/business?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as YellowpagesBusiness;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/yellowpages/business
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.yellowpages.com/los-angeles-ca/mip/anawalt-lumber-13945594?lid=1002108313121"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "name": "Ritz Plumbing Heating, Air & Electrical",
  "phone": "example",
  "rating": "five",
  "address": "1355 S La Brea Ave, Los Angeles, CA 90019",
  "website": "http://www.ritzplumbinginc.org",
  "categories": [
    "Plumbers",
    "Air Conditioning Contractors & Systems"
  ],
  "rating_count": 3
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `name` | string |  |
| `phone` | string |  |
| `rating` | string |  |
| `address` | string |  |
| `website` | string |  |
| `categories` | string[] |  |
| `rating_count` | integer |  |

## Yellowpages Search API

Search Yellow Pages businesses from a full search URL and retrieve names, phones, addresses, ratings, opening hours, and pagination via browser rendering.

`GET | POST https://api.piloterr.com/v2/yellowpages/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Full Yellow Pages search URL. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/yellowpages/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.yellowpages.com/los-angeles-ca/plumbers",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type YellowpagesSearch = {
  results?: {
    url?: string;
    name?: string;
    phone?: string;
    postal_code?: string;
    rating_value?: number;
    review_count?: number;
    opening_hours?: string[];
    address_region?: string;
    street_address?: string;
    address_country?: string;
    address_locality?: string;
  }[];
  pagination?: {
    next?: number;
    current?: number;
    next_url?: string;
    per_page?: number;
    other_pages?: number[];
    total_count?: number;
    total_pages?: number;
    has_next_page?: boolean;
  };
};

const params = new URLSearchParams({
  "query": "https://www.yellowpages.com/los-angeles-ca/plumbers",
});

const response = await fetch(`https://api.piloterr.com/v2/yellowpages/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as YellowpagesSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/yellowpages/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.yellowpages.com/los-angeles-ca/plumbers"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "url": "https://www.yellowpages.com/los-angeles-ca/mip/anawalt-lumber-13945594?lid=1002108313121",
      "name": "Anawalt Lumber",
      "phone": "example",
      "postal_code": "90064",
      "rating_value": 4.8,
      "review_count": 5,
      "opening_hours": [
        "Mo-Fr 06:00-20:00",
        "Sa 08:00-20:00"
      ],
      "address_region": "CA",
      "street_address": "11060 W Pico Blvd",
      "address_country": "US",
      "address_locality": "Los Angeles"
    },
    {
      "url": "https://www.yellowpages.com/los-angeles-ca/mip/emergency-rooter-542379108?lid=1002116238752",
      "name": "Emergency Rooter",
      "phone": "example",
      "postal_code": "90019",
      "rating_value": 4.5,
      "review_count": 2,
      "opening_hours": [
        "Mo-Su"
      ],
      "address_region": "CA",
      "street_address": "1319 S La Brea Ave",
      "address_country": "US",
      "address_locality": "Los Angeles"
    }
  ],
  "pagination": {
    "next": 2,
    "current": 1,
    "next_url": "https://www.yellowpages.com/los-angeles-ca/plumbers?page=2",
    "per_page": 30,
    "other_pages": [
      2,
      3
    ],
    "total_count": 1401,
    "total_pages": 47,
    "has_next_page": true
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].phone` | string |  |
| `results[].postal_code` | string |  |
| `results[].rating_value` | number |  |
| `results[].review_count` | integer |  |
| `results[].opening_hours` | string[] |  |
| `results[].address_region` | string |  |
| `results[].street_address` | string |  |
| `results[].address_country` | string |  |
| `results[].address_locality` | string |  |
| `pagination` | object |  |
| `pagination.next` | integer |  |
| `pagination.current` | integer |  |
| `pagination.next_url` | string |  |
| `pagination.per_page` | integer |  |
| `pagination.other_pages` | integer[] |  |
| `pagination.total_count` | integer |  |
| `pagination.total_pages` | integer |  |
| `pagination.has_next_page` | boolean |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Business | Search |
|---|---|---|
| cURL (Bash) | [`business`](examples/curl/business.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`business`](examples/php/business.php) | [`search`](examples/php/search.php) |
| C# | [`business`](examples/csharp/Business.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`business`](examples/go/business.go) | [`search`](examples/go/search.go) |
| Java | [`business`](examples/java/BusinessExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`business`](examples/ruby/business.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`business`](examples/nodejs/business.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Lead generation** — Build target account lists from public company data.
- **CRM enrichment** — Keep firmographics, websites and descriptions up to date.
- **Market mapping** — Map competitors and segments across countries and industries.
- **Investment research** — Screen companies, funding and signals for deal flow.
- **Job market analytics** — Track hiring, roles and salaries where available.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Yellowpages plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Yellowpages?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/yellowpages/business` **2**, `/v2/yellowpages/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Yellowpages API return?

Each endpoint returns structured JSON: **Yellowpages Business** — `name`, `phone`, `rating`, `address`, `website`, `categories`; **Yellowpages Search** — `results[]`, `results[].url`, `results[].name`, `results[].phone`, `results[].postal_code`, `results[].rating_value`.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Official SDKs

Use Piloterr from your own language with a typed client:

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@piloterr/sdk`](https://www.npmjs.com/package/@piloterr/sdk) | `npm install @piloterr/sdk` |
| Python | [`piloterr`](https://pypi.org/project/piloterr/) | `pip install piloterr` |
| Go | [`piloterr-go`](https://pkg.go.dev/github.com/piloterr/piloterr-go) | `go get github.com/piloterr/piloterr-go` |
| .NET | [`Piloterr`](https://www.nuget.org/packages/Piloterr) | `dotnet add package Piloterr` |
| Ruby | [`piloterr`](https://rubygems.org/gems/piloterr) | `gem install piloterr` |
| PHP | [`piloterr/sdk`](https://packagist.org/packages/piloterr/sdk) | `composer require piloterr/sdk` |
| Java | [`piloterr-java`](https://github.com/piloterr/piloterr-java) | build from source, see its README |
| CLI | [`@piloterr/cli`](https://www.npmjs.com/package/@piloterr/cli) | `npm install -g @piloterr/cli` |
| MCP server | [`@piloterr/mcp`](https://www.npmjs.com/package/@piloterr/mcp) | `npx -y @piloterr/mcp` |

## Related scrapers

- [Company Database Scraper API](https://github.com/piloterr/company-data-api)
- [Crunchbase Scraper API](https://github.com/piloterr/crunchbase-scraper)
- [Europages Scraper API](https://github.com/piloterr/europages-scraper)
- [Fiverr Scraper API](https://github.com/piloterr/fiverr-scraper)
- [G2 Scraper API](https://github.com/piloterr/g2-scraper)
- [GitHub Scraper API](https://github.com/piloterr/github-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Yellowpages is a trademark of its respective owner. This repository is not affiliated with or endorsed by Yellowpages. Examples are released under the MIT license.</sub>
