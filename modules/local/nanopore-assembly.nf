// assembly methods for Nanopore workflows
process metaflye {
    tag "MetaFlye assembly on ${sample_id}"
    label "process_medium"
    publishDir "$params.out_dir"+"/assembly/${sample_id}", mode: "copy", pattern: "*.{log,txt,gfa,fasta}"
    errorStrategy 'ignore'

    input:
        tuple val(sample_id), path(reads)
        val(flye_opts)
    output:
        tuple val(sample_id), path("${sample_id}.fasta"), emit: fasta
        tuple val(sample_id), path("${sample_id}.gfa"), emit: gfa
        tuple val(sample_id), path("flye.log"), emit: flye_log
        tuple val(sample_id), path("assembly_info.txt"), optional: true, emit: info_txt
    shell:
        """
        flye --nano-raw ${reads} -t ${task.cpus} --meta --out-dir . ${flye_opts}
        mv assembly.fasta ${sample_id}.fasta
        mv assembly_graph.gfa ${sample_id}.gfa
        """
}

process dragonflye {
    tag "DragonFlye assembly on ${sample_id}"
    label "process_medium"
    publishDir "$params.out_dir"+"/assembly/${sample_id}", mode: "copy", pattern: "*.{log,txt,gfa}"
    errorStrategy 'ignore'

    input:
        tuple val(sample_id), path(reads)
        val(flye_opts)
    output:
        tuple val(sample_id), path("${sample_id}.fasta"), emit: fasta
        tuple val(sample_id), path("${sample_id}.gfa"), emit: gfa
        tuple val(sample_id), path("dragonflye.log"), emit: dragonflye_log
        tuple val(sample_id), path("flye-info.txt"), optional: true, emit: info_txt
    script:
        def timestamp = sample_id.replaceAll('_TIME_.*', '')
        def id = sample_id.replaceAll('.*_TIME_', '')
        """
        dragonflye --reads ${reads} --cpus ${task.cpus} --outdir . --force --ram ${task.memory.toGiga()} ${flye_opts}    
        mv contigs.fa ${sample_id}.fasta
        mv flye-unpolished.gfa ${sample_id}.gfa
        """
}