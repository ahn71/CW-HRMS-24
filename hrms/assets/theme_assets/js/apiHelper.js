// apiHelper.js
function ApiCall(url, token) {
    return new Promise(function (resolve, reject) {
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
                console.error('Error occurred while fetching data:', status, error);
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
                console.error('Error occurred while fetching data:', status, error);
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
                console.error('Error occurred while fetching data:', status, error);
                reject(error);
            }
        });
    });
}

