---
name: show-me
description: >-
  Explain things to me with a diagram or chart on an HTML page. Use when I
  ask you to explain something. The how and why skills draw their pictures
  with it. Not for /in-your-own-words.
---

# Show me

Answer with a short HTML page that has one main picture. Pick the picture
that fits the question:

- Boxes and arrows for how something works, in the order things happen.
- Before and after, side by side, for what changes.
- A bar chart to compare numbers, or a line chart for change over time.
- A table of options, for a choice between them.

Build the page this way:

- Show the one-sentence answer and the picture without scrolling.
- Highlight the path, bar or cell that answers the question.
- Write labels on the shapes. Put each note next to the part it explains,
  not in a legend.
- Use the real names and numbers from the code or system.
- Cut anything that doesn't answer the question, including decoration.
- Keep paragraphs under 50 words, one idea each. Number the steps of a
  process.
- Keep the page still. If stepping through helps, add Back and Next buttons
  with "step 2 of 4". Nothing moves on its own.
- Put detail in collapsed sections below the picture.
- Make the page readable on a phone without zooming.
- Before you show the page, check a preview and fix any overlapping text.

Show me the page as a rendered HTML preview in the chat. Also serve it so
I can open it on my other devices:

- Serve a folder that holds only the page, never the repo or home folder.
- Use the machine's Tailscale or VPN address if it has one, or else its
  local network address. Give me the full URL.
- Keep the server running in the background. Stop it when I say I'm done.

If you can't render a preview, the URL is enough. If you can't serve the
page either, write the `.html` file and give me its full path.

Don't post a page with private data to a public link. Serve it only on the
Tailscale or VPN address.

Under the preview, give me the one-sentence answer. If I say "I'm not
understanding", draw it a different way.
