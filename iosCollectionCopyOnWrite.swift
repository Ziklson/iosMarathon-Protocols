import Foundation

func address(of object: UnsafeRawPointer) -> String {
    let addr=Int(bitPattern: object)
    return String(format: "%p", addr)
}

func address(off value: AnyObject) -> String {
    return "\(Unmanaged.passUnretained(value).toOpaque())"
}


// Класс, который хранит данные для структуры
class IOSCollectionStorage<T> {
    // Массив элементов
    var items: [T]
    
    // Инициализатор с копированием массива
    init(items: [T]) {
        self.items = items
    }
    
    // Добавление элемента в конец массива
    func append(_ item: T) {
        items.append(item)
    }
    
    // Получение элемента по индексу
    func get(at index: Int) -> T {
        return items[index]
    }
    
    // Установка элемента по индексу
    func set(at index: Int, to item: T) {
        items[index] = item
    }
    
    // Количество элементов в массиве
    func count() -> Int {
        return items.count
    }
    
    // Создание копии хранилища
    func copy() -> IOSCollectionStorage<T> {
        return IOSCollectionStorage<T>(items: self.items)
    }
}

// Структура, которая оборачивает класс хранилища и поддерживает copy on write
struct IOSCollection<T> {
    // Ссылка на хранилище
    var storage: IOSCollectionStorage<T>
    
    // Инициализатор по умолчанию
    init(storage: IOSCollectionStorage<T>) {
        self.storage = storage
    }
    
    // Добавление элемента в конец коллекции
    mutating func append(_ item: T) {
        // Проверка, является ли хранилище уникально ссылочным
        if !isKnownUniquelyReferenced(&storage) {
            // Если нет, то создаем новое хранилище с копией данных
            storage = storage.copy()
        }
        // Добавляем элемент в хранилище
        storage.append(item)
    }
    
    // Получение элемента по индексу
    func get(at index: Int) -> T {
        return storage.get(at: index)
    }
    
    // Установка элемента по индексу
    mutating func set(at index: Int, to item: T) {
        // Проверка, является ли хранилище уникально ссылочным
        if !isKnownUniquelyReferenced(&storage) {
            // Если нет, то создаем новое хранилище с копией данных
            storage = storage.copy()
        }
        // Устанавливаем элемент в хранилище
        storage.set(at: index, to: item)
    }
    
    // Количество элементов в коллекции
    func count() -> Int {
        return storage.count()
    }
}

var arr: [Int] = [1,2,3,4,5]

var collection = IOSCollectionStorage(items: arr)

var collection1 = IOSCollection(storage: collection) 
var collection2 = collection1

print(address(off: collection1.storage))
print(address(off: collection2.storage))

collection2.append(3)
print("------------------------------------")


print(address(off: collection1.storage))
print(address(off: collection2.storage))
