function BlockQuote(el)
  -- 1. Helper to extract text from the first element
  local first_block = el.content[1]
  if not first_block or first_block.t ~= "Para" then return nil end
  
  local first_inline = first_block.content[1]
  if not first_inline or first_inline.t ~= "Str" then return nil end

  local text = first_inline.text
  
  -- Match pattern [!type]
  if not text:match("^%[!%w+%]") then return nil end

  -- 2. Extract type (info, warning, etc.)
  local callout_type = text:match("^%[!(%w+)%]"):lower()
  
  -- 3. Cleanup and Extract the Title safely
  first_block.content:remove(1) 
  if #first_block.content > 0 and first_block.content[1].t == "Space" then
      first_block.content:remove(1)
  end
  
  -- Convert title to LaTeX to preserve math ($...$) and symbols
  local title_doc = pandoc.Pandoc({first_block})
  local title_tex = pandoc.write(title_doc, 'latex')
  title_tex = title_tex:gsub("\n", "") -- strip newline

  if title_tex == "" then 
      title_tex = callout_type:gsub("^%l", string.upper)
  end
  
  el.content:remove(1) -- Remove title paragraph from body

  -- 4. Map types to colors
  local color = "gray"
  if callout_type == "info" then
    color = "azure4"
  elseif callout_type == "warning" or callout_type == "attention" or callout_type == "danger" then
    color = "firebrick3"
  elseif callout_type == "help" or callout_type == "tip" or callout_type == "success" then
    color = "chartreuse4"
  elseif callout_type == "note" then
    color = "gray"
  end

  -- 5. Create LaTeX tcolorbox
  local header_tex = string.format(
    "\\begin{tcolorbox}[colback=%s!5!white, colframe=%s, title={%s}, fonttitle=\\bfseries]", 
    color, color, title_tex
  )
  
  table.insert(el.content, 1, pandoc.RawBlock("latex", header_tex))
  table.insert(el.content, pandoc.RawBlock("latex", "\\end{tcolorbox}"))

  return el.content
end

function Image(el)
  -- 1. Resize: Constrain BOTH width and height
  -- This prevents tall images from taking up the whole page
  el.attributes['width'] = '0.75\\linewidth'   -- Max 75% of page width
  el.attributes['height'] = '0.35\\textheight' -- Max 35% of page height
  el.attributes['keepaspectratio'] = 'true'    -- Essential to prevent distortion
  
  -- 2. Border settings
  -- \fboxsep: padding between image and border
  -- \fboxrule: thickness of the border line
  -- \fcolorbox{frame}{background}{content}
  -- We use 'gray!40' for a subtle border and 'white' for the background
  local border_start = '\\begin{center}\\setlength{\\fboxsep}{1pt}\\setlength{\\fboxrule}{0.5pt}\\fcolorbox{gray!40}{white}{'
  local border_end = '}\\end{center}'

  return {
      pandoc.RawInline('latex', border_start),
      el,
      pandoc.RawInline('latex', border_end)
  }
end
