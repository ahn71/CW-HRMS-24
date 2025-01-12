function GetCompanys() {
            ApiCall(GetDdlCompanyUrl, token)
                .then(function (response) {
                    if (response.statusCode === 200) {
                        var responseData = response.data;
                        console.log('company Data', responseData);
                        const formattedData = responseData.map(item => ({
                            value: item.companyId,
                            text: item.companyName
                        }));


                        populateDropdown('ddlCompany', formattedData);

                    } else {
                        console.error('Error occurred while fetching data:', response.message);
                    }
                })
                .catch(function (error) {
                    console.error('Error occurred while fetching data:', error);
                });
        }

        function populateDropdown(dropdownId, data, defaultOption = "---Select---") {
            const dropdown = document.getElementById(dropdownId);
           if (data.length === 1) {
                dropdown.value = data[0].value;
            }
            else {
                dropdown.innerHTML = `<option value="0">${defaultOption}</option>`;
            }
            data.forEach(item => {
                const option = document.createElement('option');
                option.value = item.value;  
                option.textContent = item.text;
                dropdown.appendChild(option);
            });
        }

