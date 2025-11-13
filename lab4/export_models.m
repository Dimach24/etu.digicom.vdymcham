% Получаем список всех .slx файлов в текущей директории
current_directory = pwd; % Текущая директория
model_files = dir(fullfile(current_directory, '*.slx')); % Ищем все .slx файлы

% Создаем подпапку R2022a, если она еще не существует
output_folder = fullfile(current_directory, 'R2022a');
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Проходим по всем найденным моделям
for i = 1:length(model_files)
    % Имя файла без расширения
    model_name = model_files(i).name;
    [~, name, ~] = fileparts(model_name); % Убираем расширение .slx
    
    % Полный путь к исходной модели
    source_model_path = fullfile(current_directory, model_name);
    
    % Полный путь для сохранения модели в подпапке R2022a
    target_model_path = fullfile(output_folder, [name '.slx']);
    
    % Открываем модель (если она еще не открыта)
    open_system(source_model_path);
    
    % Сохраняем модель в формате, совместимом с MATLAB 2022a
    save_system(name, target_model_path, 'SaveAsVersion', 'R2022a');
    close_system(gcs, 0);
    % Выводим информацию о процессе
    fprintf('Модель "%s" успешно экспортирована в "%s"\n', name, target_model_path);
end

% Закрываем все открытые модели после завершения

fprintf('Экспорт завершен. Все модели сохранены в папку "%s".\n', output_folder);