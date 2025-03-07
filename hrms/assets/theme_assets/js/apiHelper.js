﻿// apiHelper.js
function ApiCall(url, token) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url,
            type: 'GET',
       
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                //console.log(status);
                //var message = xhr.responseJSON.message
                //console.log('Error occurred while fetching data:', message);
                var message = xhr.responseJSON.message;
                console.error('Error occurred while fetching data:', message);
                reject({ message: message, status: status, error: error });
            }
        });
    });
}
function ApiCallWithPeram(baseUrl, token, userId, companyId) {
    return new Promise(function (resolve, reject) {
        // Correctly format the URL with userId in the path and companyId as a query parameter
        const url = `${baseUrl}/${userId}?CompanyId=${companyId}`;

        $.ajax({
            url: url, // Use the constructed URL
            type: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.log('Error occurred while fetching data:', status, error);
                reject(error);
            }
        });
    });
}

function ApiCallwithCompanyId(baseUrl, token, companyId) {
    return new Promise(function (resolve, reject) {
        // Correctly format the URL with userId in the path and companyId as a query parameter
        const url = `${baseUrl}/${companyId}`;

        $.ajax({
            url: url, // Use the constructed URL
            type: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.log('Error occurred while fetching data:', status, error);
                reject(error);
            }
        });
    });
}
function ApiCallwithEmp(baseUrl, token, companyId, EmpId) {
    return new Promise(function (resolve, reject) {
        // Format the URL to include companyId as part of the path and EmpId as a query parameter
        const url = `${baseUrl}/${companyId}?EmpId=${EmpId}`;

        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.log('Error occurred while fetching data:', status, error);
                reject(error);
            }
        });
    });
}

function ApiCallAuthority(baseUrl, token, companyId, UserId) {
    return new Promise(function (resolve, reject) {
        // Construct the URL using template literals
        const url = `${baseUrl}/${companyId}?UserId=${UserId}`;

        $.ajax({
            url: url,
            type: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.log('Error occurred while fetching data:', status, error);
                reject(error);
            }
        });
    });
}

function ApiCallById(url, token, id) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url + '/' + id,
            type: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            data: {
                moduleID: id,
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.log('Error occurred while fetching data:', status, error);
                reject(error);
            }
        });
    });
}

function ApiCallByCompId(url, token, id, companyID) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: `${url}/${id}`, // Constructs the URL dynamically with the id
            type: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token // Adds Bearer token for authentication
            },
            data: {
                moduleID: id, // Sends id in the data object
                companyID: companyID // Adds companyID as a parameter in the request
            },
            success: function (data) {
                resolve(data); // Resolves the Promise with the response data
            },
            error: function (xhr, status, error) {
                console.error('Error occurred while fetching data:', status, error); // Logs error details
                reject(error); // Rejects the Promise with the error
            }
        });
    });
}

function ApiCallByGuestUser(url, token, isGuestUser, companyId) {
    if (!url) {
        return Promise.reject("URL is required.");
    }
    if (!token) {
        return Promise.reject("Authorization token is required.");
    }

    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url, // Base API URL
            type: 'GET',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            data: {
                IsGuestUser: isGuestUser,
                companyId: companyId
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.error('Error occurred while fetching data:', status, error);
                reject({
                    status: xhr.status,
                    statusText: xhr.statusText,
                    response: xhr.responseText || error
                });
            }
        });
    });
}



function ApiCallImageUpdate(url, token, formData, id) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url + '/' + id,
            type: 'POST',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            data: formData,
            contentType: false, // Let the browser set the correct content type
            processData: false, // Prevent jQuery from processing data
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.error('Error occurred while updating data:', status, error);
                reject(error);
            }
        });
    });
}




function ApiCallUpdate(url, token, updateData, id) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url + '/' + id,
            type: 'PUT',
            dataType: 'json',
            contentType: 'application/json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            data: JSON.stringify(updateData),
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.error('Error occurred while updating data:', status, error);
                reject(error);
            }
        });
    });
}

function ApiCallUpdateWithoutId(url, token, updateData) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url,
            type: 'PUT',
            dataType: 'json',
            contentType: 'application/json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            data: JSON.stringify(updateData),
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.error('Error occurred while updating data:', status, error);
                reject(error);
            }
        });
    });
}

function ApiDeleteById(url, token, id) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url + '/' + id,
            type: 'DELETE',
            dataType: 'json',
            headers: {
                'Authorization': 'Bearer ' + token
            },
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                console.error('Error occurred while deleting data:', status, error);
                reject(error);
            }
        });
    });
}

function ApiCallPost(url, token, postData) {
    return new Promise(function (resolve, reject) {
        $.ajax({
            url: url,
            type: 'POST',  // Changed type to 'POST'
            dataType: 'json',
            contentType: 'application/json',  // Added contentType for JSON
            headers: {
                'Authorization': 'Bearer ' + token
            },
            data: JSON.stringify(postData),  // Added data for POST request
            success: function (data) {
                resolve(data);
            },
            error: function (xhr, status, error) {
                //console.error('Error occurred while fetching data:', status, error);
                var message = xhr.responseText;
                console.log(message)

                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: message
                });

                //reject(error);
            }
        });
    });
}


