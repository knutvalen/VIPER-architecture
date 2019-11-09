class CodeModelFactory {
    static func build(
        title: String? = nil,
        rules: String? = nil
    ) -> CodeModel {
        return CodeModel(
            title: title,
            rules: rules
        )
    }
    
}
