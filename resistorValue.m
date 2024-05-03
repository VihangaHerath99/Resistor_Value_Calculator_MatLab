function resistorValue(params)
    % Define default values
    defaultParams.bandNo = 0;
    defaultParams.col1 = 'None';
    defaultParams.col2 = 'None';
    defaultParams.col3 = 'None';
    defaultParams.colMul = 'None';
    defaultParams.colTol = 'None';
    
    % Merge user-provided parameters with default parameters
    if nargin < 1
        params = struct();
    end
    params = mergeStructs(defaultParams, params);
    
    % Access parameters
    bandNo = params.bandNo;
    col1 = params.col1;
    col2 = params.col2;
    col3 = params.col3;
    colMul = params.colMul;
    colTol = params.colTol;
    
    % Find the corresponding color band values
    col1Value = getColorValue(col1);
    col2Value = getColorValue(col2);
    col3Value = getColorValue(col3);
    colMulValue = getColorMulValue(colMul);
    colTolValue = getColorTolValue(colTol);
    
    % check the validity of inputs
    col1_validity = checkValidity(col1Value);
    col2_validity = checkValidity(col2Value);
    col3_validity = checkValidity(col3Value);
    colMul_validity = checkValidity(colMulValue);
    colTol_validity = checkValidity(colTolValue);
    if ~col1_validity
        error('Invalid input fot param.col1, see the instructions using mainInfo() function')
    elseif ~col2_validity
        error('Invalid input fot param.col2, see the instructions using mainInfo() function')
    elseif ~col3_validity && bandNo==5
        error('Invalid input fot param.col3, see the instructions using mainInfo() function')
    elseif ~colMul_validity
        error('Invalid input fot param.colMul, see the instructions using mainInfo() function')
    elseif ~colTol_validity
        error('Invalid input fot param.colTol, see the instructions using mainInfo() function')
    end
    
    % calculate the resistor value and tolerance based on no.of color bands
    if bandNo == 4
        resistor_value = (col2Value*1 + col1Value*10)*colMulValue;
        disp({bandNo, col1, col2, colMul, colTol})
    elseif bandNo == 5
        resistor_value = (col3Value*1 + col2Value*10 + col1Value*100)*colMulValue;
        disp({bandNo, col1, col2, col3, colMul, colTol})
    else
        error("Invalid input for param.bandNo, see the instructions using mainInfo() function")
    end
    disp(['Resistor Value = ', num2str(resistor_value), ' Ohms  Tolerance = +/-', num2str(colTolValue),'%'])
end

function mergedStruct = mergeStructs(struct1, struct2)
    % Merge two structures, with values from struct2 taking precedence
    mergedStruct = struct1;
    fields = fieldnames(struct2);
    for i = 1:numel(fields)
        fieldName = fields{i};
        mergedStruct.(fieldName) = struct2.(fieldName);
    end
end

% Find values of first 2 or 3 color bands
function colorValue = getColorValue(colorName)
    % Convert color name to lowercase for case-insensitive comparison
    colorName = lower(colorName);
    
    % Initialize color value
    colorValue = 'Unknown';
    
    % Check color name and assign corresponding value
    switch colorName
        case 'black'
            colorValue = 0;
        case 'brown'
            colorValue = 1;
        case 'red'
            colorValue = 2;
        case 'orange'
            colorValue = 3;
        case 'yellow'
            colorValue = 4;
        case 'green'
            colorValue = 5;
        case 'blue'
            colorValue = 6;
        case 'violet'
            colorValue = 7;
        case 'gray'
            colorValue = 8;
        case 'white'
            colorValue = 9;
    end
end

% Find the value of Multiplication color band
function colorMulValue = getColorMulValue(colorName)
    % Convert color name to lowercase for case-insensitive comparison
    colorName = lower(colorName);
    
    % Initialize color value
    colorMulValue = 'Unknown';
    
    % Check color name and assign corresponding value
    switch colorName
        case 'black'
            colorMulValue = 1;
        case 'brown'
            colorMulValue = 10;
        case 'red'
            colorMulValue = 100;
        case 'orange'
            colorMulValue = 1000;
        case 'yellow'
            colorMulValue = 10000;
        case 'green'
            colorMulValue = 100000;
        case 'blue'
            colorMulValue = 1000000;
        case 'gold'
            colorMulValue = 0.1;
        case 'silver'
            colorMulValue = 0.01;
    end
end

% Find the value of Tolerance color band
function colorTolValue = getColorTolValue(colorName)
    % Convert color name to lowercase for case-insensitive comparison
    colorName = lower(colorName);
    
    % Initialize color value
    colorTolValue = 'Unknown';
    
    % Check color name and assign corresponding value
    switch colorName
        case 'brown'
            colorTolValue = 1;
        case 'red'
            colorTolValue = 2;
        case 'gold'
            colorTolValue = 5;
        case 'silver'
            colorTolValue = 10;
    end
end

% Check the validity of inputs
function valid = checkValidity(col)
    if strcmp(col, 'Unknown')
        valid = false;
    else
        valid = true;
    end
end