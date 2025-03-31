local dropDownList = {}

export type DropDownList<Index> = {
	Buttons: { [Index]: Frame }
}

function dropDownList.new<Index>(points: { [Index]: Frame }): DropDownList<Index>
    local self = {
		
    }

	return self
end

return dropDownList
