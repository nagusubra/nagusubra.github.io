---
title: "Databricks AI Agents Hackathon - Commodities Trading"
description: "Won 2nd prize at the Databricks AI Agents Hackathon with a lightweight ontology system linking geopolitical events to commodities markets."
publishDate: 2026-03-22
tags: ["ai","agents","databricks","hackathon","sidequests"]
kind: "note"
draft: false
---

How can you interlink geopolitical and world events with commodities trading?

We answered that question and got 2nd prize at the Databricks AI Agents Hackathon in Calgary, hosted by Tech Connect Alberta, Databricks, and Adastra at the Calgary Public Library - Central Library.

Commodities traders already live inside a firehose of information from news, production data, infrastructure disruptions, geopolitics, policy changes, and supply chain signals. The challenge isn't data access. The challenge is signal extraction: Raw market data to contextual market intelligence.

So we built a lightweight ontology system that links global events, news, and industry signals to commodities markets and surfaces decision intelligence for traders, helping frame buy / sell / hold decisions.

We wrapped the whole workflow in a medallion architecture:

- **Bronze**: Collect all market data
- **Silver**: Filter and batch process text data using AI parsing functions
- **Gold**: Create a summary of the market data, ready to be served

The pipelines are scalable since they were built from scratch for parallel processing and historical backfill capabilities.

A huge thank you to Scott McKean and Volodymyr Vragov — it gave me a new perspective on Graph Knowledge databases. I had a lot of fun creating this with my team, Matthew Anand and Pratham Shah.

![](/posts/databricks-ai-agents-hackathon/img-01.jpg)

![](/posts/databricks-ai-agents-hackathon/img-02.jpg)
