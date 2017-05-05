'''
cd /var/www/git/More/Finite-Capacitance/z_dev_notes/issue_1_and_2/; python3 eval_C_vs_Nxy.py 
'''
from matplotlib import pyplot as plt;
import numpy as np;


desired_data_set_index = 1;
this_file = "data_table.md"; 

Nxy_list = [];
Nz_list = [];
C_list = [];

data_dictionary = dict();
with open(this_file, 'r') as fp:
    source_lines = fp.readlines();
    data_set_index = -1;
    for index, line in enumerate(source_lines):
        parts = line.rstrip().split("|");
        
        ## Make sure we're getting data we're interested in 
        if(len(parts) < 3): continue; ## not a data row
        if(parts[1] == ""): continue;
        if("---" in parts[1]):  continue;
        if("N_xy" in parts[1]): 
            data_set_index += 1; ## increment data_set index (0 = E_field along path, 1 = potential explicit 
            continue;
        if(data_set_index > desired_data_set_index): break;
        if(data_set_index != desired_data_set_index): continue;
        
        ## Grab parts of data we're interested in
        Nxy = int(parts[1]);
        Nz = int(parts[2]);
        C = float(parts[4]);
        
        if(Nxy < 1000): continue;
        

        ## Stick data in dictionary
        if(Nxy not in data_dictionary):
            data_dictionary[Nxy] = dict({
                "C" : [],
                "Nz" : [],
                });
        
        data_dictionary[Nxy]["Nz"].append(Nz);
        data_dictionary[Nxy]["C"].append(C);
        
        #Nxy_list.append(Nxy);
        #Nz_list.append(Nz);
        #C_list.append(C);
        
print(data_dictionary);
        
    
##############################
## Normalize Data of each Nxy into centered and unit variance datapoints
##############################
def normalize_array_data(data):
    data = np.array(data);
    data = data-np.mean(data);
    data = data/np.std(data);
    return data;
def normalized_std(data):
    ## Normalized Standard Deviation is Std/Mean = percentage of deviation = Coefficient of Variation
    data = np.array(data);
    data = np.std(data)/np.mean(data);
    return data;
final_data = dict();
for key, value in data_dictionary.items():
    
    if(False):
        ## Return the Normalized Standard Deviation for this data set
        normalized_data = normalize_array_data(value["C"]);
        Nz_for_this_data = value["Nz"];
        
    if(True): 
        ## Return the Normalized Standard Deviation for this data set 
        normalized_data = [normalized_std(value["C"])];
        Nz_for_this_data = [1];
        
    final_data[key] = dict({
                "C" : normalized_data,
                "Nz" : Nz_for_this_data,
            });
    
print(final_data);
    
    
##############################
## Generate conical list of all data
##############################
Nxy_list = [];
Nz_list = [];
C_list = [];
for key, value in final_data.items():
    for index in range(len(value["C"])):
        this_C = value["C"][index];
        this_Nz = value["Nz"][index];
        Nxy_list.append(key);
        Nz_list.append(this_Nz);
        C_list.append(this_C);

        

#################################
## Output Plots
#################################
X_data = Nxy_list;
Y_data = C_list;
print(Y_data);
color = [str(item/255.) for item in Nz_list];


plt.title('CV -vs- Nxy for Direct Potential Calculation', fontsize=12)
plt.xlabel('Sqrt of Discrete Elements in XY Plane (Nxy)', fontsize=12)
plt.ylabel('Coefficient of Variation in Capacitance', fontsize=12)
plt.scatter(X_data, Y_data, s=50, c=color)
plt.show()