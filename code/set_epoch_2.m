function [raise_time_list1, reaction_time_list1,raise_time_list2, reaction_time_list2, EEG2] = set_epoch_2(EEG,eventstr,thres)

%eeglab-function for producing epochs
EEG2 = pop_epoch( EEG, {eventstr}, [-0.05    0.15], 'newname', 'epochs', 'epochinfo', 'yes');
EEG2 = eeg_checkset(EEG2);
%----normalize Data-----
[x_norm, y_norm] = normalize(EEG2.data);

%-----choose right trigger with thresholds-----
if strcmp(thres,'fix')
    if strcmp(eventstr,'100')
        thresTarget =  -0.95;
        thresOrigin =  -0.05;
    else
        thresTarget =  -0.05; %target
        thresOrigin =  -0.95; %origin
    end
    thresOrigin_y = thresOrigin;
    thresTarget_y = thresTarget;
else
    
%-----thresholds bei gradient-----

%     my_list_origin = nan(1,size(data,3));
%     for ep = 1:size(data,3)
%         for k = 1:size(data,2)
%             if abs(data(1,k,ep) - data(1,k-1,ep)) > 0.015
%                 my_list_origin(ep) = data(k)
%             else
%                 continue
%             end
%         end
%     end
%     
%     origin = EEG2.data(1,my_list_origin,:) %???????????
%     my_thres_origin = % mean �ber y-werte aus my_list_origin
%     
%     my_list_target = nan(1,size(data,3));
%     for ep = 1:size(data,3)
%         for k = 40:size(data,2)
%             if abs(data(1,k,ep) - data(1,k-1,ep)) < 0.015
%                 my_list_target(ep) = data(k)
%             else
%                 continue
%             end
%         end
%     end
%     
%     target = EEG2.data(1,my_list_target,:) %????????????
%     my_thres_target = % mean �ber y-werte aus my_list_target
%     
%     if strcmp(eventstr,'100')
%         thresTarget = my_thres_target;
%         thresOrigin = my_thres_origin;
%     else
%         thresTarget =  my_thres_origin; %target
%         thresOrigin =  my_thres_target; %origin
    

    time_between_o = EEG2.times > -50 & EEG2.times < 0;
    data_between_o = x_norm(1,time_between_o,:);
    thresOrigin = mean(data_between_o,2);
    
    time_between_t = EEG2.times > 50 & EEG2.times < 100;
    data_between_t = x_norm(1,time_between_t,:);
    thresTarget = mean(data_between_t,2);

    data_between_o = y_norm(1,time_between_o,:);
    thresOrigin_y = mean(data_between_o,2);
    
    data_between_t = y_norm(1,time_between_t,:);
    thresTarget_y = mean(data_between_t,2);
    
end
    
    
    
    
%output
[raise_time_list1, reaction_time_list1] = find_raisetime_gen(thresTarget, thresOrigin, x_norm, EEG2.times);
[raise_time_list2, reaction_time_list2] = find_raisetime_gen(thresTarget_y, thresOrigin_y, y_norm, EEG2.times);
