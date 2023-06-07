function Meta(meta)
  local function safe_json(obj)
    if type(obj) == "userdata" then
      return pandoc.utils.stringify(obj)
    end
    if type(obj) == "table" then
      local result = {}
      for k, v in pairs(obj) do
        result[k] = safe_json(v)
      end
      return result
    end
    return obj
  end
  local info = {
    filename = safe_json(quarto.doc.input_file),
    metadata = safe_json(meta)
  }
  local output = quarto.json.encode(info)
  local filename = pandoc.path.join({quarto.project.directory or ".", 'metadata.json'})
  local f = io.open(filename,'a')
  if f == nil then
    error("Couldn't open file")
    return
  end
  f:write(output)
  f:write("\n")
  f:close()
end
