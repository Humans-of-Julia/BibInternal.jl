struct BibtexRules <: AbstractRulesSet end

function generate_bibtex_rules()
    rules = EntryFieldRules()

    # Rules for AddressField
    for entry in [
            :article,
            :misc,
            :unpublished
        ]
        rules[(entry, :address)] = IgnoredRule()
    end
    for entry in [
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport
        ]
        rules[(entry, :address)] = OptionalRule()
    end

    # Rules for AnnoteField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :annote)] = IgnoredRule()
    end

    # Rules for AuthorField
    for entry in [
            :article,
            :incollection,
            :inproceedings,
            :phdthesis,
            :masterthesis,
            :techreport,
            :unpublished
        ]
        rules[(entry, :author)] = RequiredRule()
    end
    for entry in [
            :booklet,
            :manual,
            :misc
        ]
        rules[(entry, :author)] = OptionalRule()
    end
    for entry in [
            :book,
            :inbook
        ]
        rules[(entry, :author)] = ExclusivelyRequiredRule([:editor])
    end
    for entry in [
            :proceedings
        ]
        rules[(entry, :author)] = IgnoredRule()
    end

    # Rules for BookTitleField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :booktitle)] = IgnoredRule()
    end
    for entry in [
            :incollection,
            :inproceedings
        ]
        rules[(entry, :booktitle)] = RequiredRule()
    end

    # Rules for ChapterField
    for entry in [
            :article,
            :book,
            :booklet,
            :inproceedings,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :chapterfield)] = IgnoredRule()
    end
    for entry in [
            :incollection
        ]
        rules[(entry, :chapterfield)] = OptionalRule()
    end
    for entry in [
            :inbook
        ]
        rules[(entry, :chapterfield)] = InclusivelyRequiredRule([:pages])
    end

    # Rules for CrossRefField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
            ]
        rules[(entry, :crossref)] = IgnoredRule()
    end

    # Rules for EditionField
    for entry in [
            :book,
            :inbook,
            :incollection,
            :manual
            ]
        rules[(entry, :edition)] = OptionalRule()
    end
    for entry in [
            :article,
            :booklet,
            :inproceedings,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :edition)] = IgnoredRule()
    end

    # Rules for EditorField
    for entry in [
            :article,
            :booklet,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :techreport,
            :unpublished
        ]
        rules[(entry, :editor)] = IgnoredRule()
    end
    for entry in [
            :book,
            :inbook
        ]
        rules[(entry, :editor)] = ExclusivelyRequiredRule([:author])
    end
    for entry in [
            :incollection,
            :inproceedings,
            :proceedings
            ]
        rules[(entry, :editor)] = OptionalRule()
    end

    # Rules for HowPublishedField
    for entry in [
            :article,
            :book,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :howpublished)] = IgnoredRule()
    end
    for entry in [
            :booklet,
            :misc
        ]
        rules[(entry, :howpublished)] = OptionalRule()
    end

    # Rules for InstitutionField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :unpublished
        ]
        rules[(entry, :institution)] = IgnoredRule()
    end
    for entry in [
            :techreport
        ]
        rules[(entry, :institution)] = RequiredRule()
    end

    # Rules for JournalField
    for entry in [
            :article
        ]
        rules[(entry, :journal)] = RequiredRule()
    end
    for entry in [
                :book,
                :booklet,
                :inbook,
                :incollection,
                :inproceedings,
                :manual,
                :misc,
                :phdthesis,
                :masterthesis,
                :proceedings,
                :techreport,
                :unpublished
            ]
        rules[(entry, :journal)] = IgnoredRule()
    end

    # Rules for KeyField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :key)] = IgnoredRule()
    end

    # Rules for MonthField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :month)] = OptionalRule()
    end

    # Rules for NoteField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport
        ]
        rules[(entry, :note)] = OptionalRule()
    end
    for entry in [
            :unpublished
        ]
        rules[(entry, :note)] = RequiredRule()
    end

    # Rules for NumberField
    for entry in [
            :booklet,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :unpublished
        ]
        rules[(entry, :number)] = IgnoredRule()
    end
    for entry in [
            :article,
            :book,
            :inbook,
            :incollection,
            :inproceedings,
            :proceedings,
            :techreport
        ]
        rules[(entry, :number)] = OptionalRule()
    end

    # Rules for OrganizationField
    for entry in [
            :inproceedings,
            :manual,
            :proceedings
        ]
        rules[(entry, :organization)] = OptionalRule()
    end
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :misc,
            :phdthesis,
            :masterthesis,
            :techreport,
            :unpublished
        ]
        rules[(entry, :organization)] = IgnoredRule()
    end

    # Rules for PagesField
    for entry in [
            :inbook
        ]
        rules[(entry, :pages)] = InclusivelyRequiredRule([:chapterfield])
    end
    for entry in [
            :article,
            :incollection,
            :inproceedings
        ]
        rules[(entry, :pages)] = OptionalRule()
    end
    for entry in [
            :book,
            :booklet,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :pages)] = IgnoredRule()
    end

    # Rules for PublisherField
    for entry in [
            :book,
            :inbook,
            :incollection
        ]
        rules[(entry, :publisher)] = RequiredRule()
    end
    for entry in [
            :inproceedings,
            :proceedings
        ]
        rules[(entry, :publisher)] = OptionalRule()
    end
    for entry in [
            :article,
            :booklet,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :techreport,
            :unpublished
        ]
        rules[(entry, :publisher)] = IgnoredRule()
    end

    # Rules for SchoolField
    for entry in [
            :phdthesis,
            :masterthesis
        ]
        rules[(entry, :school)] = RequiredRule()
    end
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :misc,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :school)] = IgnoredRule()
    end

    # Rules for SeriesField
    for entry in [
            :article,
            :booklet,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :techreport,
            :unpublished
        ]
        rules[(entry, :series)] = IgnoredRule()
    end
    for entry in [
            :book,
            :inbook,
            :incollection,
            :inproceedings,
            :proceedings
        ]
        rules[(entry, :series)] = OptionalRule()
    end

    # Rules for TitleField
    for entry in [
            :article,
            :book,
            :booklet,
            :inbook,
            :incollection,
            :inproceedings,
            :manual,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport,
            :unpublished
        ]
        rules[(entry, :title)] = RequiredRule()
    end
    for entry in [
            :misc
        ]
        rules[(entry, :title)] = OptionalRule()
    end

    # Rules for TypeField
    for entry in [
            :inbook,
            :incollection,
            :phdthesis,
            :masterthesis,
            :techreport
        ]
        rules[(entry, :type)] = OptionalRule()
    end
    for entry in [
            :article,
            :book,
            :booklet,
            :inproceedings,
            :manual,
            :misc,
            :proceedings,
            :unpublished
        ]
        rules[(entry, :type)] = IgnoredRule()
    end

    # Rules for VolumeField
    for entry in [
            :article,
            :book,
            :inbook,
            :incollection,
            :inproceedings,
            :proceedings
        ]
        rules[(entry, :volume)] = OptionalRule()
    end
    for entry in [
            :booklet,
            :manual,
            :misc,
            :phdthesis,
            :masterthesis,
            :techreport,
            :unpublished
        ]
        rules[(entry, :volume)] = IgnoredRule()
    end

    # Rules for YearField
    for entry in [
            :booklet,
            :manual,
            :misc,
            :unpublished
        ]
        rules[(entry, :year)] = OptionalRule()
    end
    for entry in [
            :article,
            :book,
            :inbook,
            :incollection,
            :inproceedings,
            :phdthesis,
            :masterthesis,
            :proceedings,
            :techreport
        ]
        rules[(entry, :year)] = RequiredRule()
    end

    return rules
end
