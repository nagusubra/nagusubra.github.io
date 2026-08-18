---
title: "Asset Nav Assistant - Databricks GenAI World Cup"
description: "Built an end-to-end RAG solution for asset document navigation in the Databricks Generative AI World Cup."
publishDate: 2024-04-25
tags: ["genai","databricks","hackathon","rag","sidequests"]
kind: "note"
draft: false
---

![](/posts/databricks-genai-asset-nav/img-01.jpg)

Asset Nav Assistant - navigating asset documentation with GenAI.

Excited to share our latest project, Asset Nav Assistant! After two weeks of intense learning, collaboration, and rapid prototyping alongside Jingwen (Belinda) Huang, we're thrilled to unveil this tool for asset diagnosis.

Asset Nav Assistant is your go-to reliable ally for navigating asset documents and history, making diagnosis easier for professionals by providing them with actionable recommendations.

We employed Databricks and AWS as our foundational technologies. Harnessing the power of industry-leading cloud providers, we constructed an end-to-end RAG pipeline. Our core Large Language Model for this pipeline is the Mixtral 7B model, complemented by the DBRX instruct model for evaluation purposes. The pipeline includes:

- **Preparation**: Parse, chunk, and store task-specific data in vector format in Unity Catalog.
- **Retrieval**: Employ the bge-large-en model for retrieval tasks.
- **Augmentation**: Add related prompt templates to prepare a more comprehensive response.
- **Generation**: Utilize the Mixtral 7B model to generate responses based on retrieved and augmented information.
- **Evaluation**: Evaluate the generated response to ensure quality, readability, relevance, professionalism, and faithfulness.

A big thanks to Databricks for hosting the Generative AI World Cup, where we were able to refine our skills. It was an enriching experience to learn, develop, integrate, and deploy a GenAI application.

P.S. I thought two weeks would provide ample time to avoid pulling all-nighters compared to day-long hackathons, but I was wrong!

Check out the project: [https://github.com/nagusubra/databricks_hackathon_2024](https://github.com/nagusubra/databricks_hackathon_2024)
