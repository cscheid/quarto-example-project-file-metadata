local f = io.open('metadata.json','w')
if f == nil then
    error("couldn't open file for writing")
end
f:close()